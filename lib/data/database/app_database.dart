import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/app_settings_table.dart';
import 'tables/audio_recordings_table.dart';
import 'tables/reminder_history_table.dart';
import 'tables/reminder_times_table.dart';
import 'tables/routines_table.dart';
import 'daos/routine_dao.dart';
import 'daos/reminder_history_dao.dart';
import 'daos/settings_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    RoutinesTable,
    ReminderTimesTable,
    AudioRecordingsTable,
    ReminderHistoryTable,
    AppSettingsTable,
  ],
  daos: [
    RoutineDao,
    ReminderHistoryDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'cueme_database',
      native: const DriftNativeOptions(
        shareAcrossIsolates: true,
      ),
    );
  }
}
