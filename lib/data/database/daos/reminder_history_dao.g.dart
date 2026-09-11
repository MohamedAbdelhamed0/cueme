// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_history_dao.dart';

// ignore_for_file: type=lint
mixin _$ReminderHistoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReminderHistoryTableTable get reminderHistoryTable =>
      attachedDatabase.reminderHistoryTable;
  ReminderHistoryDaoManager get managers => ReminderHistoryDaoManager(this);
}

class ReminderHistoryDaoManager {
  final _$ReminderHistoryDaoMixin _db;
  ReminderHistoryDaoManager(this._db);
  $$ReminderHistoryTableTableTableManager get reminderHistoryTable =>
      $$ReminderHistoryTableTableTableManager(
        _db.attachedDatabase,
        _db.reminderHistoryTable,
      );
}
