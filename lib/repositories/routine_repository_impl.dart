import '../data/database/daos/routine_dao.dart';
import '../data/mappers/database_mappers.dart';
import '../domain/entities/routine.dart';
import '../domain/repositories/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final RoutineDao _routineDao;

  RoutineRepositoryImpl(this._routineDao);

  @override
  Stream<List<Routine>> watchActive() {
    return _routineDao.watchActiveRoutines().map((list) {
      return list.map((item) => item.toDomain()).toList();
    });
  }

  @override
  Stream<List<Routine>> watchArchived() {
    return _routineDao.watchArchivedRoutines().map((list) {
      return list.map((item) => item.toDomain()).toList();
    });
  }

  @override
  Future<List<Routine>> getAllActive() async {
    final list = await _routineDao.getAllActiveRoutines();
    return list.map((item) => item.toDomain()).toList();
  }

  @override
  Future<Routine?> getById(String id) async {
    final details = await _routineDao.getRoutineById(id);
    return details?.toDomain();
  }

  @override
  Future<void> saveRoutine(Routine routine) async {
    await _routineDao.upsertRoutine(
      routineCompanion: routine.toCompanion(),
      reminderTimeCompanions: routine.reminderTimes.map((t) => t.toCompanion()).toList(),
      audioCompanion: routine.audioRecording?.toCompanion(),
    );
  }

  @override
  Future<void> deleteRoutine(String id) async {
    await _routineDao.deleteRoutine(id);
  }

  @override
  Future<void> setActive(String id, bool active) async {
    await _routineDao.setActive(id, active);
  }

  @override
  Future<void> setArchived(String id, bool archived) async {
    await _routineDao.setArchived(id, archived);
  }
}
