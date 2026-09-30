import '../../domain/entities/routine.dart';
import '../../domain/enums/reminder_enums.dart';

class ScheduleVerification {
  final Set<int> expectedIds;
  final Set<int> pendingIds;
  const ScheduleVerification(this.expectedIds, this.pendingIds);
  Set<int> get missingIds => expectedIds.difference(pendingIds);
  bool get isComplete => missingIds.isEmpty;
}

abstract interface class ReminderScheduler {
  Future<void> initialize({
    void Function(String payload)? onNotificationTapped,
  });
  Future<ScheduleVerification> scheduleRoutine(Routine routine);
  Future<void> cancelRoutine(Routine routine);
  Future<void> cancelByNotificationId(int notificationId);
  Future<void> rescheduleAll(List<Routine> activeRoutines);
  Future<bool> requestNotificationPermission();
  Future<ExactAlarmCapability> getExactAlarmCapability();
  Future<void> testNotification();
}
