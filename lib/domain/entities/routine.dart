import '../enums/reminder_enums.dart';
import '../enums/routine_category.dart';
import 'audio_recording.dart';
import 'reminder_time.dart';

class Routine {
  final String id;
  final String name;
  final RoutineCategory category;
  final String? actionVerb;
  final String? dosageText;
  final String? instructions;
  final String iconKey;
  final String colorKey;
  final bool isActive;
  final bool isArchived;
  final DateTime startDate;
  final DateTime? endDate;
  final int weekdaysMask;
  final ReminderSoundMode soundMode;
  final String? audioId;
  final bool vibrationEnabled;
  final bool snoozeEnabled;
  final int snoozeMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Joined relations
  final List<ReminderTime> reminderTimes;
  final AudioRecording? audioRecording;

  const Routine({
    required this.id,
    required this.name,
    required this.category,
    this.actionVerb,
    this.dosageText,
    this.instructions,
    required this.iconKey,
    required this.colorKey,
    this.isActive = true,
    this.isArchived = false,
    required this.startDate,
    this.endDate,
    required this.weekdaysMask,
    this.soundMode = ReminderSoundMode.system,
    this.audioId,
    this.vibrationEnabled = true,
    this.snoozeEnabled = true,
    this.snoozeMinutes = 10,
    required this.createdAt,
    required this.updatedAt,
    this.reminderTimes = const [],
    this.audioRecording,
  });

  String get verb => actionVerb ?? category.defaultVerb;

  bool isScheduledForWeekday(int weekday) {
    // DateTime weekday: 1 (Mon) to 7 (Sun)
    if (weekday < 1 || weekday > 7) return false;
    final bit = 1 << (weekday - 1);
    return (weekdaysMask & bit) != 0;
  }

  Set<int> get selectedWeekdays {
    final days = <int>{};
    for (int i = 1; i <= 7; i++) {
      if (isScheduledForWeekday(i)) {
        days.add(i);
      }
    }
    return days;
  }

  static int maskFromWeekdays(Iterable<int> weekdays) {
    int mask = 0;
    for (final day in weekdays) {
      if (day >= 1 && day <= 7) {
        mask |= (1 << (day - 1));
      }
    }
    return mask;
  }

  Routine copyWith({
    String? id,
    String? name,
    RoutineCategory? category,
    String? actionVerb,
    String? dosageText,
    String? instructions,
    String? iconKey,
    String? colorKey,
    bool? isActive,
    bool? isArchived,
    DateTime? startDate,
    DateTime? endDate,
    int? weekdaysMask,
    ReminderSoundMode? soundMode,
    String? audioId,
    bool? vibrationEnabled,
    bool? snoozeEnabled,
    int? snoozeMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ReminderTime>? reminderTimes,
    AudioRecording? audioRecording,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      actionVerb: actionVerb ?? this.actionVerb,
      dosageText: dosageText ?? this.dosageText,
      instructions: instructions ?? this.instructions,
      iconKey: iconKey ?? this.iconKey,
      colorKey: colorKey ?? this.colorKey,
      isActive: isActive ?? this.isActive,
      isArchived: isArchived ?? this.isArchived,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      weekdaysMask: weekdaysMask ?? this.weekdaysMask,
      soundMode: soundMode ?? this.soundMode,
      audioId: audioId ?? this.audioId,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      audioRecording: audioRecording ?? this.audioRecording,
    );
  }
}
