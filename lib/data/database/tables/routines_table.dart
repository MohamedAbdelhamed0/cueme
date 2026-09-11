import 'package:drift/drift.dart';

@DataClassName('RoutineRow')
class RoutinesTable extends Table {
  @override
  String get tableName => 'routines';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get actionVerb => text().nullable()();
  TextColumn get dosageText => text().nullable()();
  TextColumn get instructions => text().nullable()();

  TextColumn get iconKey => text()();
  TextColumn get colorKey => text()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();

  IntColumn get weekdaysMask => integer()();

  TextColumn get soundMode => text()();
  TextColumn get audioId => text().nullable()();

  BoolColumn get vibrationEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get snoozeEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get snoozeMinutes => integer().withDefault(const Constant(10))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
