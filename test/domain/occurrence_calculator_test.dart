import 'package:flutter_test/flutter_test.dart';
import 'package:cueme/domain/entities/reminder_history_entry.dart';
import 'package:cueme/domain/entities/reminder_time.dart';
import 'package:cueme/domain/entities/routine.dart';
import 'package:cueme/domain/enums/reminder_enums.dart';
import 'package:cueme/domain/enums/routine_category.dart';
import 'package:cueme/domain/services/occurrence_calculator.dart';

void main() {
  group('OccurrenceCalculator Tests', () {
    final targetDate = DateTime(2026, 9, 11); // Friday (weekday = 5)

    final morningTime = ReminderTime(
      id: 'time-1',
      routineId: 'routine-1',
      hour: 8,
      minute: 0,
      notificationId: 101,
      createdAt: DateTime(2026, 9, 1),
      updatedAt: DateTime(2026, 9, 1),
    );

    final eveningTime = ReminderTime(
      id: 'time-2',
      routineId: 'routine-1',
      hour: 20,
      minute: 30,
      notificationId: 102,
      createdAt: DateTime(2026, 9, 1),
      updatedAt: DateTime(2026, 9, 1),
    );

    final routine = Routine(
      id: 'routine-1',
      name: 'Face Cream',
      category: RoutineCategory.cream,
      iconKey: 'cream',
      colorKey: 'lavender',
      startDate: DateTime(2026, 9, 1),
      weekdaysMask: 127, // all days
      createdAt: DateTime(2026, 9, 1),
      updatedAt: DateTime(2026, 9, 1),
      reminderTimes: [eveningTime, morningTime], // intentionally unordered
    );

    test('Computes and orders daily occurrences', () {
      final occurrences = OccurrenceCalculator.computeOccurrences(
        routines: [routine],
        historyEntries: [],
        targetDate: targetDate,
        currentTime: DateTime(2026, 9, 11, 7, 0), // 7:00 AM (before morning)
      );

      expect(occurrences.length, 2);
      expect(occurrences[0].reminderTime.hour, 8);
      expect(occurrences[0].status, OccurrenceStatus.upcoming);
      expect(occurrences[1].reminderTime.hour, 20);
      expect(occurrences[1].status, OccurrenceStatus.upcoming);
    });

    test('Marks occurrence as done when history contains done action', () {
      final historyDone = ReminderHistoryEntry(
        id: 'h-1',
        routineId: 'routine-1',
        reminderTimeId: 'time-1',
        scheduledFor: DateTime(2026, 9, 11, 8, 0),
        action: ReminderAction.done,
        actionAt: DateTime(2026, 9, 11, 8, 5),
        createdAt: DateTime(2026, 9, 11, 8, 5),
      );

      final occurrences = OccurrenceCalculator.computeOccurrences(
        routines: [routine],
        historyEntries: [historyDone],
        targetDate: targetDate,
        currentTime: DateTime(2026, 9, 11, 9, 0),
      );

      expect(occurrences[0].status, OccurrenceStatus.done);
      expect(occurrences[1].status, OccurrenceStatus.upcoming);
    });

    test('Finds next reminder correctly', () {
      final occurrences = OccurrenceCalculator.computeOccurrences(
        routines: [routine],
        historyEntries: [],
        targetDate: targetDate,
        currentTime: DateTime(2026, 9, 11, 8, 10), // Morning is due
      );

      final next = OccurrenceCalculator.findNextReminder(occurrences);
      expect(next, isNotNull);
      expect(next!.reminderTime.hour, 8);
      expect(next.status, OccurrenceStatus.due);
    });

    test('Ignores inactive or archived routines', () {
      final inactiveRoutine = routine.copyWith(isActive: false);
      final archivedRoutine = routine.copyWith(isArchived: true);

      final occurrences1 = OccurrenceCalculator.computeOccurrences(
        routines: [inactiveRoutine],
        historyEntries: [],
        targetDate: targetDate,
      );
      expect(occurrences1, isEmpty);

      final occurrences2 = OccurrenceCalculator.computeOccurrences(
        routines: [archivedRoutine],
        historyEntries: [],
        targetDate: targetDate,
      );
      expect(occurrences2, isEmpty);
    });
  });
}
