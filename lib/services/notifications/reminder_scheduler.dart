import '../../domain/entities/routine.dart';
import '../../domain/enums/reminder_enums.dart';

abstract interface class ReminderScheduler {
  Future<void> initialize({void Function(String payload)? onNotificationTapped});
  Future<void> scheduleRoutine(Routine routine);
  Future<void> cancelRoutine(Routine routine);
  Future<void> cancelByNotificationId(int notificationId);
  Future<void> rescheduleAll(List<Routine> activeRoutines);
  Future<bool> requestNotificationPermission();
  Future<ExactAlarmCapability> getExactAlarmCapability();
  Future<void> testNotification();
}
