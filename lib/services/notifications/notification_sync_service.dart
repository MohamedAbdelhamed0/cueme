import '../../core/utils/app_logger.dart';
import '../../domain/repositories/routine_repository.dart';
import 'reminder_scheduler.dart';

class NotificationSyncService {
  final RoutineRepository _routineRepository;
  final ReminderScheduler _scheduler;
  String? _lastKnownTimezone;

  NotificationSyncService(this._routineRepository, this._scheduler);

  Future<void> reconcile() async {
    try {
      AppLogger.info('NotificationSyncService', 'Starting schedule reconciliation...');

      final currentTimezone = DateTime.now().timeZoneName;
      final timezoneChanged = _lastKnownTimezone != null && _lastKnownTimezone != currentTimezone;
      _lastKnownTimezone = currentTimezone;

      final activeRoutines = await _routineRepository.getAllActive();

      if (timezoneChanged) {
        AppLogger.info('NotificationSyncService', 'Timezone changed from $_lastKnownTimezone to $currentTimezone. Rescheduling all.');
        await _scheduler.rescheduleAll(activeRoutines);
      } else {
        // Refresh schedules for all active routines
        for (final routine in activeRoutines) {
          await _scheduler.scheduleRoutine(routine);
        }
      }

      AppLogger.info('NotificationSyncService', 'Reconciliation finished successfully.');
    } catch (e, st) {
      AppLogger.error('NotificationSyncService', 'Reconciliation error', e, st);
    }
  }
}
