import '../../core/utils/app_logger.dart';
import '../../domain/repositories/routine_repository.dart';
import 'reminder_scheduler.dart';

class NotificationSyncService {
  final RoutineRepository _routineRepository;
  final ReminderScheduler _scheduler;
  NotificationSyncService(this._routineRepository, this._scheduler);

  Future<void> reconcile({bool rebuildAll = false}) async {
    try {
      // The scheduler reloads inside its queue, checks the actual IANA timezone,
      // prunes obsolete IDs, and verifies each routine without cancelling valid
      // due alarms. Legacy payloads are rebuilt once after upgrading.
      await _scheduler.rescheduleAll(await _routineRepository.getAllActive());
      AppLogger.info(
        'NotificationSyncService',
        'Schedule reconciliation verified',
      );
    } catch (error, stack) {
      AppLogger.error(
        'NotificationSyncService',
        'Reconciliation error',
        error,
        stack,
      );
    }
  }
}
