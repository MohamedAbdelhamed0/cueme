import 'package:drift/drift.dart';

@DataClassName('AppSettingsRow')
class AppSettingsTable extends Table {
  @override
  String get tableName => 'app_settings';

  IntColumn get id => integer().withDefault(const Constant(1))();

  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  TextColumn get accentStyle => text().withDefault(const Constant('default'))();
  BoolColumn get useDynamicColor => boolean().withDefault(const Constant(false))();

  TextColumn get timeFormat => text().withDefault(const Constant('system'))();
  IntColumn get defaultSnoozeMinutes => integer().withDefault(const Constant(10))();
  BoolColumn get defaultVibration => boolean().withDefault(const Constant(true))();

  BoolColumn get onboardingCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get notificationEducationSeen => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
