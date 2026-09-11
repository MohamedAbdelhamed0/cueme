import 'package:flutter_test/flutter_test.dart';
import 'package:cueme/domain/entities/routine.dart';
import 'package:cueme/domain/enums/routine_category.dart';

void main() {
  group('Weekday Bitmask Tests', () {
    test('Calculates correct mask for Monday to Sunday', () {
      final allDays = {1, 2, 3, 4, 5, 6, 7};
      final mask = Routine.maskFromWeekdays(allDays);
      // 1<<0 + 1<<1 + 1<<2 + 1<<3 + 1<<4 + 1<<5 + 1<<6 = 1 + 2 + 4 + 8 + 16 + 32 + 64 = 127
      expect(mask, 127);
    });

    test('Calculates correct mask for Mon, Wed, Fri', () {
      final days = {1, 3, 5};
      final mask = Routine.maskFromWeekdays(days);
      // 1<<0 + 1<<2 + 1<<4 = 1 + 4 + 16 = 21
      expect(mask, 21);
    });

    test('Checks if routine is scheduled for a specific weekday', () {
      final mask = Routine.maskFromWeekdays({1, 5, 7}); // Mon, Fri, Sun
      final routine = Routine(
        id: '1',
        name: 'Test',
        category: RoutineCategory.vitamin,
        iconKey: 'vitamin',
        colorKey: 'amber',
        startDate: DateTime(2026, 1, 1),
        weekdaysMask: mask,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

      expect(routine.isScheduledForWeekday(1), isTrue); // Mon
      expect(routine.isScheduledForWeekday(2), isFalse); // Tue
      expect(routine.isScheduledForWeekday(5), isTrue); // Fri
      expect(routine.isScheduledForWeekday(6), isFalse); // Sat
      expect(routine.isScheduledForWeekday(7), isTrue); // Sun

      expect(routine.selectedWeekdays, {1, 5, 7});
    });
  });
}
