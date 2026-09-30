import 'package:timezone/timezone.dart' as tz;

/// Calendar arithmetic preserves wall-clock reminder times across DST changes.
class ReminderScheduleCalculator {
  static DateTime dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static DateTime? nextForWeekday({
    required DateTime now,
    required DateTime startDate,
    DateTime? endDate,
    required int weekday,
    required int hour,
    required int minute,
  }) {
    final firstDay = dateOnly(startDate).isAfter(dateOnly(now))
        ? startDate
        : now;
    DateTime at(int offset) => now is tz.TZDateTime
        ? tz.TZDateTime(
            now.location,
            firstDay.year,
            firstDay.month,
            firstDay.day + offset,
            hour,
            minute,
          )
        : DateTime(
            firstDay.year,
            firstDay.month,
            firstDay.day + offset,
            hour,
            minute,
          );
    var offset = (weekday - firstDay.weekday) % 7;
    var next = at(offset);
    if (!next.isAfter(now)) next = at(offset += 7);
    if (endDate != null && dateOnly(next).isAfter(dateOnly(endDate))) {
      return null;
    }
    return next;
  }

  static DateTime? next({
    required DateTime now,
    required DateTime startDate,
    DateTime? endDate,
    required Set<int> weekdays,
    required Iterable<({int hour, int minute})> times,
  }) {
    DateTime? earliest;
    for (final time in times) {
      for (final weekday in weekdays) {
        final candidate = nextForWeekday(
          now: now,
          startDate: startDate,
          endDate: endDate,
          weekday: weekday,
          hour: time.hour,
          minute: time.minute,
        );
        if (candidate != null &&
            (earliest == null || candidate.isBefore(earliest))) {
          earliest = candidate;
        }
      }
    }
    return earliest;
  }
}
