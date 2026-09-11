import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/app_settings_table.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [AppSettingsTable])
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Future<AppSettingsRow> getSettings() async {
    final existing = await (select(appSettingsTable)..where((tbl) => tbl.id.equals(1))).getSingleOrNull();
    if (existing != null) return existing;

    final now = DateTime.now();
    final defaultSettings = AppSettingsTableCompanion.insert(
      id: const Value(1),
      themeMode: const Value('system'),
      accentStyle: const Value('default'),
      useDynamicColor: const Value(false),
      timeFormat: const Value('system'),
      defaultSnoozeMinutes: const Value(10),
      defaultVibration: const Value(true),
      onboardingCompleted: const Value(false),
      notificationEducationSeen: const Value(false),
      createdAt: now,
      updatedAt: now,
    );
    await into(appSettingsTable).insert(defaultSettings);
    return (await (select(appSettingsTable)..where((tbl) => tbl.id.equals(1))).getSingle());
  }

  Stream<AppSettingsRow> watchSettings() {
    return (select(appSettingsTable)..where((tbl) => tbl.id.equals(1)))
        .watchSingleOrNull()
        .asyncMap((existing) async {
      if (existing != null) return existing;
      return getSettings();
    });
  }

  Future<void> upsertSettings(AppSettingsTableCompanion companion) async {
    final companionWithId = companion.copyWith(
      id: const Value(1),
      updatedAt: Value(DateTime.now()),
    );
    await into(appSettingsTable).insertOnConflictUpdate(companionWithId);
  }
}
