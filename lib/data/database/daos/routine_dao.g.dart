// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_dao.dart';

// ignore_for_file: type=lint
mixin _$RoutineDaoMixin on DatabaseAccessor<AppDatabase> {
  $RoutinesTableTable get routinesTable => attachedDatabase.routinesTable;
  $ReminderTimesTableTable get reminderTimesTable =>
      attachedDatabase.reminderTimesTable;
  $AudioRecordingsTableTable get audioRecordingsTable =>
      attachedDatabase.audioRecordingsTable;
  RoutineDaoManager get managers => RoutineDaoManager(this);
}

class RoutineDaoManager {
  final _$RoutineDaoMixin _db;
  RoutineDaoManager(this._db);
  $$RoutinesTableTableTableManager get routinesTable =>
      $$RoutinesTableTableTableManager(_db.attachedDatabase, _db.routinesTable);
  $$ReminderTimesTableTableTableManager get reminderTimesTable =>
      $$ReminderTimesTableTableTableManager(
        _db.attachedDatabase,
        _db.reminderTimesTable,
      );
  $$AudioRecordingsTableTableTableManager get audioRecordingsTable =>
      $$AudioRecordingsTableTableTableManager(
        _db.attachedDatabase,
        _db.audioRecordingsTable,
      );
}
