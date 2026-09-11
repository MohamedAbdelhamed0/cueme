import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/audio_recordings_table.dart';
import '../tables/reminder_times_table.dart';
import '../tables/routines_table.dart';

part 'routine_dao.g.dart';

class RoutineWithDetails {
  final RoutineRow routine;
  final List<ReminderTimeRow> reminderTimes;
  final AudioRecordingRow? audioRecording;

  const RoutineWithDetails({
    required this.routine,
    required this.reminderTimes,
    this.audioRecording,
  });
}

@DriftAccessor(tables: [RoutinesTable, ReminderTimesTable, AudioRecordingsTable])
class RoutineDao extends DatabaseAccessor<AppDatabase> with _$RoutineDaoMixin {
  RoutineDao(super.db);

  Stream<List<RoutineWithDetails>> watchActiveRoutines() {
    final query = select(routinesTable)
      ..where((tbl) => tbl.isActive.equals(true) & tbl.isArchived.equals(false))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);

    return query.watch().asyncMap((routineRows) async {
      return _populateDetails(routineRows);
    });
  }

  Stream<List<RoutineWithDetails>> watchArchivedRoutines() {
    final query = select(routinesTable)
      ..where((tbl) => tbl.isArchived.equals(true))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)]);

    return query.watch().asyncMap((routineRows) async {
      return _populateDetails(routineRows);
    });
  }

  Future<List<RoutineWithDetails>> getAllActiveRoutines() async {
    final query = select(routinesTable)
      ..where((tbl) => tbl.isActive.equals(true) & tbl.isArchived.equals(false));
    final routineRows = await query.get();
    return _populateDetails(routineRows);
  }

  Future<RoutineWithDetails?> getRoutineById(String id) async {
    final query = select(routinesTable)..where((tbl) => tbl.id.equals(id));
    final routineRow = await query.getSingleOrNull();
    if (routineRow == null) return null;

    final timesQuery = select(reminderTimesTable)
      ..where((tbl) => tbl.routineId.equals(id))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.sortOrder), (tbl) => OrderingTerm.asc(tbl.hour), (tbl) => OrderingTerm.asc(tbl.minute)]);
    final times = await timesQuery.get();

    AudioRecordingRow? audio;
    if (routineRow.audioId != null) {
      final audioQuery = select(audioRecordingsTable)
        ..where((tbl) => tbl.id.equals(routineRow.audioId!));
      audio = await audioQuery.getSingleOrNull();
    }

    return RoutineWithDetails(
      routine: routineRow,
      reminderTimes: times,
      audioRecording: audio,
    );
  }

  Future<List<RoutineWithDetails>> _populateDetails(List<RoutineRow> routineRows) async {
    if (routineRows.isEmpty) return [];

    final routineIds = routineRows.map((r) => r.id).toList();

    final allTimes = await (select(reminderTimesTable)
          ..where((tbl) => tbl.routineId.isIn(routineIds))
          ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.sortOrder),
            (tbl) => OrderingTerm.asc(tbl.hour),
            (tbl) => OrderingTerm.asc(tbl.minute),
          ]))
        .get();

    final audioIds = routineRows.map((r) => r.audioId).whereType<String>().toList();
    final allAudio = audioIds.isEmpty
        ? <AudioRecordingRow>[]
        : await (select(audioRecordingsTable)..where((tbl) => tbl.id.isIn(audioIds))).get();

    final audioMap = {for (final a in allAudio) a.id: a};
    final timesMap = <String, List<ReminderTimeRow>>{};
    for (final t in allTimes) {
      timesMap.putIfAbsent(t.routineId, () => []).add(t);
    }

    return routineRows.map((routine) {
      return RoutineWithDetails(
        routine: routine,
        reminderTimes: timesMap[routine.id] ?? [],
        audioRecording: routine.audioId != null ? audioMap[routine.audioId!] : null,
      );
    }).toList();
  }

  Future<void> upsertRoutine({
    required RoutinesTableCompanion routineCompanion,
    required List<ReminderTimesTableCompanion> reminderTimeCompanions,
    AudioRecordingsTableCompanion? audioCompanion,
  }) {
    return transaction(() async {
      if (audioCompanion != null) {
        await into(audioRecordingsTable).insertOnConflictUpdate(audioCompanion);
      }

      await into(routinesTable).insertOnConflictUpdate(routineCompanion);

      final routineId = routineCompanion.id.value;

      // Keep existing reminder times that are still present, replace or delete stale
      await (delete(reminderTimesTable)..where((tbl) => tbl.routineId.equals(routineId))).go();

      for (final time in reminderTimeCompanions) {
        await into(reminderTimesTable).insert(time);
      }
    });
  }

  Future<void> deleteRoutine(String id) {
    return transaction(() async {
      final routine = await (select(routinesTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
      if (routine?.audioId != null) {
        await (delete(audioRecordingsTable)..where((tbl) => tbl.id.equals(routine!.audioId!))).go();
      }
      // reminderTimes cascade deletes via foreign key
      await (delete(routinesTable)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Future<void> setActive(String id, bool active) async {
    await (update(routinesTable)..where((tbl) => tbl.id.equals(id))).write(
      RoutinesTableCompanion(
        isActive: Value(active),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setArchived(String id, bool archived) async {
    await (update(routinesTable)..where((tbl) => tbl.id.equals(id))).write(
      RoutinesTableCompanion(
        isArchived: Value(archived),
        // Archiving automatically deactivates
        isActive: Value(!archived),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
