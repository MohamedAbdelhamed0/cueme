class ReminderTime {
  final String id;
  final String routineId;
  final int hour;
  final int minute;
  final int sortOrder;
  final bool isEnabled;
  final int notificationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReminderTime({
    required this.id,
    required this.routineId,
    required this.hour,
    required this.minute,
    this.sortOrder = 0,
    this.isEnabled = true,
    required this.notificationId,
    required this.createdAt,
    required this.updatedAt,
  });

  String formatTime({bool is24Hour = false}) {
    if (is24Hour) {
      final h = hour.toString().padLeft(2, '0');
      final m = minute.toString().padLeft(2, '0');
      return '$h:$m';
    }
    final period = hour >= 12 ? 'PM' : 'AM';
    final h = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m $period';
  }

  ReminderTime copyWith({
    String? id,
    String? routineId,
    int? hour,
    int? minute,
    int? sortOrder,
    bool? isEnabled,
    int? notificationId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReminderTime(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      sortOrder: sortOrder ?? this.sortOrder,
      isEnabled: isEnabled ?? this.isEnabled,
      notificationId: notificationId ?? this.notificationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
