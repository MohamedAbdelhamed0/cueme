import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String toFormattedTime({bool is24Hour = false}) {
    if (is24Hour) {
      return DateFormat('HH:mm').format(this);
    }
    return DateFormat('hh:mm a').format(this);
  }

  String toFormattedDate() {
    return DateFormat('EEE, MMM d').format(this);
  }

  String toMonthDayYear() {
    return DateFormat('MMM d, yyyy').format(this);
  }

  DateTime startOfDay() {
    return DateTime(year, month, day);
  }

  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }
}
