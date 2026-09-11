import '../enums/reminder_enums.dart';
import 'reminder_history_entry.dart';
import 'reminder_time.dart';
import 'routine.dart';

class TodayOccurrence {
  final String id;
  final Routine routine;
  final ReminderTime reminderTime;
  final DateTime scheduledDateTime;
  final OccurrenceStatus status;
  final ReminderHistoryEntry? historyEntry;

  const TodayOccurrence({
    required this.id,
    required this.routine,
    required this.reminderTime,
    required this.scheduledDateTime,
    required this.status,
    this.historyEntry,
  });

  bool get isCompleted =>
      status == OccurrenceStatus.done ||
      status == OccurrenceStatus.skipped;

  bool get isPending =>
      status == OccurrenceStatus.upcoming ||
      status == OccurrenceStatus.due ||
      status == OccurrenceStatus.snoozed;

  TodayOccurrence copyWith({
    String? id,
    Routine? routine,
    ReminderTime? reminderTime,
    DateTime? scheduledDateTime,
    OccurrenceStatus? status,
    ReminderHistoryEntry? historyEntry,
  }) {
    return TodayOccurrence(
      id: id ?? this.id,
      routine: routine ?? this.routine,
      reminderTime: reminderTime ?? this.reminderTime,
      scheduledDateTime: scheduledDateTime ?? this.scheduledDateTime,
      status: status ?? this.status,
      historyEntry: historyEntry ?? this.historyEntry,
    );
  }
}
