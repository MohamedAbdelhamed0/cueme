import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/database/daos/reminder_history_dao.dart';
import '../../data/database/daos/routine_dao.dart';
import '../../data/database/daos/settings_dao.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/entities/routine.dart';
import '../../domain/entities/today_occurrence.dart';
import '../../domain/repositories/history_repository.dart';
import '../../domain/repositories/routine_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/services/occurrence_calculator.dart';
import '../../repositories/history_repository_impl.dart';
import '../../repositories/routine_repository_impl.dart';
import '../../repositories/settings_repository_impl.dart';
import '../../services/audio/audio_preview_service.dart';
import '../../services/audio/audio_storage_service.dart';
import '../../services/audio/voice_recorder_service.dart';
import '../../services/audio/voice_recorder_service_impl.dart';
import '../../services/notifications/flutter_local_notification_scheduler.dart';
import '../../services/notifications/notification_id_service.dart';
import '../../services/notifications/notification_sync_service.dart';
import '../../services/notifications/reminder_scheduler.dart';
import '../../services/permissions/permission_service.dart';

// Database & DAOs
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final routineDaoProvider = Provider<RoutineDao>((ref) {
  return ref.watch(appDatabaseProvider).routineDao;
});

final reminderHistoryDaoProvider = Provider<ReminderHistoryDao>((ref) {
  return ref.watch(appDatabaseProvider).reminderHistoryDao;
});

final settingsDaoProvider = Provider<SettingsDao>((ref) {
  return ref.watch(appDatabaseProvider).settingsDao;
});

// Repositories
final routineRepositoryProvider = Provider<RoutineRepository>((ref) {
  return RoutineRepositoryImpl(ref.watch(routineDaoProvider));
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(ref.watch(reminderHistoryDaoProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(ref.watch(settingsDaoProvider));
});

// Platform Services
final reminderSchedulerProvider = Provider<ReminderScheduler>((ref) {
  return FlutterLocalNotificationScheduler(
    routineRepository: ref.watch(routineRepositoryProvider),
  );
});

final notificationIdServiceProvider = Provider<NotificationIdService>((ref) {
  return NotificationIdService(ref.watch(appDatabaseProvider));
});

final voiceRecorderServiceProvider = Provider<VoiceRecorderService>((ref) {
  final service = VoiceRecorderServiceImpl();
  ref.onDispose(() => service.dispose());
  return service;
});

final audioStorageServiceProvider = Provider<AudioStorageService>((ref) {
  return AudioStorageService();
});

final audioPreviewServiceProvider = Provider<AudioPreviewService>((ref) {
  final service = AudioPreviewService();
  ref.onDispose(() => service.dispose());
  return service;
});

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});

final notificationSyncServiceProvider = Provider<NotificationSyncService>((
  ref,
) {
  return NotificationSyncService(
    ref.watch(routineRepositoryProvider),
    ref.watch(reminderSchedulerProvider),
  );
});

// Reactive Streams
final activeRoutinesStreamProvider = StreamProvider<List<Routine>>((ref) {
  return ref.watch(routineRepositoryProvider).watchActive();
});

final archivedRoutinesStreamProvider = StreamProvider<List<Routine>>((ref) {
  return ref.watch(routineRepositoryProvider).watchArchived();
});

final appSettingsStreamProvider = StreamProvider<AppSettings>((ref) {
  return ref.watch(settingsRepositoryProvider).watchSettings();
});

// Today timeline occurrences stream
final todayOccurrencesProvider = FutureProvider<List<TodayOccurrence>>((
  ref,
) async {
  final routinesAsync = ref.watch(activeRoutinesStreamProvider);
  final routines = routinesAsync.value ?? [];
  final historyEntries = await ref
      .watch(historyRepositoryProvider)
      .getTodayEntries();

  return OccurrenceCalculator.computeOccurrences(
    routines: routines,
    historyEntries: historyEntries,
    targetDate: DateTime.now(),
  );
});
