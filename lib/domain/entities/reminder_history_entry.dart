import '../enums/reminder_enums.dart';

class ReminderHistoryEntry {
  final String id;
  final String routineId;
  final String? reminderTimeId;
  final DateTime scheduledFor;
  final ReminderAction action;
  final DateTime? actionAt;
  final DateTime? snoozedUntil;
  final String? note;
  final DateTime createdAt;

  // Snapshot fields for resilient historical rendering
  final String? routineNameSnapshot;
  final String? categorySnapshot;

  const ReminderHistoryEntry({
    required this.id,
    required this.routineId,
    this.reminderTimeId,
    required this.scheduledFor,
    required this.action,
    this.actionAt,
    this.snoozedUntil,
    this.note,
    required this.createdAt,
    this.routineNameSnapshot,
    this.categorySnapshot,
  });

  ReminderHistoryEntry copyWith({
    String? id,
    String? routineId,
    String? reminderTimeId,
    DateTime? scheduledFor,
    ReminderAction? action,
    DateTime? actionAt,
    DateTime? snoozedUntil,
    String? note,
    DateTime? createdAt,
    String? routineNameSnapshot,
    String? categorySnapshot,
  }) {
    return ReminderHistoryEntry(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      reminderTimeId: reminderTimeId ?? this.reminderTimeId,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      action: action ?? this.action,
      actionAt: actionAt ?? this.actionAt,
      snoozedUntil: snoozedUntil ?? this.snoozedUntil,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      routineNameSnapshot: routineNameSnapshot ?? this.routineNameSnapshot,
      categorySnapshot: categorySnapshot ?? this.categorySnapshot,
    );
  }
}
