import 'package:drift/drift.dart';
import 'routines_table.dart';

@DataClassName('ReminderTimeRow')
class ReminderTimesTable extends Table {
  @override
  String get tableName => 'reminder_times';

  TextColumn get id => text()();
  TextColumn get routineId => text().references(RoutinesTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get hour => integer()();
  IntColumn get minute => integer()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  IntColumn get notificationId => integer().unique()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
