import '../../core/extensions/date_time_extensions.dart';
import '../entities/reminder_history_entry.dart';
import '../entities/routine.dart';
import '../entities/today_occurrence.dart';
import '../enums/reminder_enums.dart';

class OccurrenceCalculator {
  /// Computes all occurrences for a given [targetDate] from the list of [routines],
  /// reconciled with existing [historyEntries] for that day.
  static List<TodayOccurrence> computeOccurrences({
    required List<Routine> routines,
    required List<ReminderHistoryEntry> historyEntries,
    required DateTime targetDate,
    DateTime? currentTime,
  }) {
    final now = currentTime ?? DateTime.now();
    final occurrences = <TodayOccurrence>[];

    final startOfDay = targetDate.startOfDay();
    final endOfDay = targetDate.endOfDay();

    for (final routine in routines) {
      if (!routine.isActive || routine.isArchived) continue;

      // Check start & end date constraints
      if (routine.startDate.isAfter(endOfDay)) continue;
      if (routine.endDate != null && routine.endDate!.isBefore(startOfDay)) continue;

      // Check weekday mask
      if (!routine.isScheduledForWeekday(targetDate.weekday)) continue;

      for (final reminderTime in routine.reminderTimes) {
        if (!reminderTime.isEnabled) continue;

        final scheduledDateTime = DateTime(
          targetDate.year,
          targetDate.month,
          targetDate.day,
          reminderTime.hour,
          reminderTime.minute,
        );

        final occurrenceId = '${routine.id}_${reminderTime.id}_${targetDate.year}${targetDate.month.toString().padLeft(2, '0')}${targetDate.day.toString().padLeft(2, '0')}';

        // Check if there is an action in history for this routine and time
        final matchingHistory = historyEntries.where((h) {
          return h.routineId == routine.id &&
              (h.reminderTimeId == reminderTime.id ||
                  (h.scheduledFor.hour == reminderTime.hour &&
                      h.scheduledFor.minute == reminderTime.minute &&
                      h.scheduledFor.isSameDay(targetDate)));
        }).toList();

        ReminderHistoryEntry? latestHistory;
        if (matchingHistory.isNotEmpty) {
          matchingHistory.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          latestHistory = matchingHistory.first;
        }

        OccurrenceStatus status;

        if (latestHistory != null) {
          switch (latestHistory.action) {
            case ReminderAction.done:
              status = OccurrenceStatus.done;
              break;
            case ReminderAction.skipped:
              status = OccurrenceStatus.skipped;
              break;
            case ReminderAction.snoozed:
              if (latestHistory.snoozedUntil != null && now.isAfter(latestHistory.snoozedUntil!)) {
                status = OccurrenceStatus.due;
              } else {
                status = OccurrenceStatus.snoozed;
              }
              break;
            case ReminderAction.missed:
              status = OccurrenceStatus.missed;
              break;
          }
        } else {
          // No explicit history action yet
          if (now.isBefore(scheduledDateTime)) {
            status = OccurrenceStatus.upcoming;
          } else {
            // Routine time has arrived or passed
            // If within 2 hours of scheduled time, consider it actively due
            final passed = now.difference(scheduledDateTime);
            if (passed.inHours < 2) {
              status = OccurrenceStatus.due;
            } else {
              // Calm missed status if no action was taken
              status = OccurrenceStatus.missed;
            }
          }
        }

        occurrences.add(
          TodayOccurrence(
            id: occurrenceId,
            routine: routine,
            reminderTime: reminderTime,
            scheduledDateTime: scheduledDateTime,
            status: status,
            historyEntry: latestHistory,
          ),
        );
      }
    }

    // Sort chronologically by scheduled time
    occurrences.sort((a, b) => a.scheduledDateTime.compareTo(b.scheduledDateTime));
    return occurrences;
  }

  /// Finds the next relevant reminder to display on the hero card.
  static TodayOccurrence? findNextReminder(List<TodayOccurrence> occurrences) {
    // 1. Look for actively due reminder
    final dueOccurrences = occurrences.where((o) => o.status == OccurrenceStatus.due).toList();
    if (dueOccurrences.isNotEmpty) {
      return dueOccurrences.first;
    }

    // 2. Look for snoozed reminder
    final snoozedOccurrences = occurrences.where((o) => o.status == OccurrenceStatus.snoozed).toList();
    if (snoozedOccurrences.isNotEmpty) {
      return snoozedOccurrences.first;
    }

    // 3. Look for next upcoming reminder
    final upcomingOccurrences = occurrences.where((o) => o.status == OccurrenceStatus.upcoming).toList();
    if (upcomingOccurrences.isNotEmpty) {
      return upcomingOccurrences.first;
    }

    return null;
  }
}
