import 'package:cueme/domain/services/reminder_schedule_calculator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as data;
import 'package:timezone/timezone.dart' as tz;

void main() {
  test('Passed times advance and later daily times remain today', () {
    final now = DateTime(2026, 9, 30, 10);
    expect(
      ReminderScheduleCalculator.next(
        now: now,
        startDate: now,
        weekdays: {1, 2, 3, 4, 5, 6, 7},
        times: [(hour: 8, minute: 0), (hour: 14, minute: 0)],
      ),
      DateTime(2026, 9, 30, 14),
    );
    expect(
      ReminderScheduleCalculator.next(
        now: DateTime(2026, 9, 30, 15),
        startDate: now,
        weekdays: {1, 2, 3, 4, 5, 6, 7},
        times: [(hour: 8, minute: 0), (hour: 14, minute: 0)],
      ),
      DateTime(2026, 10, 1, 8),
    );
  });

  test('Start/end dates are inclusive calendar dates', () {
    final now = DateTime(2026, 9, 30, 10);
    expect(
      ReminderScheduleCalculator.nextForWeekday(
        now: now,
        startDate: DateTime(2026, 10, 7, 20),
        endDate: DateTime(2026, 10, 7),
        weekday: 3,
        hour: 8,
        minute: 0,
      ),
      DateTime(2026, 10, 7, 8),
    );
    expect(
      ReminderScheduleCalculator.nextForWeekday(
        now: now,
        startDate: DateTime(2026, 10, 8),
        endDate: DateTime(2026, 10, 8),
        weekday: 3,
        hour: 8,
        minute: 0,
      ),
      isNull,
    );
  });

  test('DST transition retains calendar day and chosen wall-clock hour', () {
    data.initializeTimeZones();
    final zone = tz.getLocation('Africa/Cairo');
    final now = tz.TZDateTime(zone, 2026, 10, 29, 20);
    final next = ReminderScheduleCalculator.nextForWeekday(
      now: now,
      startDate: now,
      weekday: 5,
      hour: 8,
      minute: 0,
    )!;
    expect(next.day, 30);
    expect(next.hour, 8);
    expect((next as tz.TZDateTime).location.name, 'Africa/Cairo');
  });
}
