import 'package:drift/drift.dart';

@DataClassName('ReminderHistoryRow')
class ReminderHistoryTable extends Table {
  @override
  String get tableName => 'reminder_history';

  TextColumn get id => text()();
  TextColumn get routineId => text()();
  TextColumn get reminderTimeId => text().nullable()();

  DateTimeColumn get scheduledFor => dateTime()();
  TextColumn get action => text()(); // done, skipped, snoozed, missed
  DateTimeColumn get actionAt => dateTime().nullable()();

  DateTimeColumn get snoozedUntil => dateTime().nullable()();
  TextColumn get note => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  // Snapshot fields
  TextColumn get routineNameSnapshot => text().nullable()();
  TextColumn get categorySnapshot => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
