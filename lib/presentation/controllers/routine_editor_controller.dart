import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../app/providers/service_providers.dart';
import '../../core/utils/app_logger.dart';
import '../../domain/entities/audio_recording.dart';
import '../../domain/entities/reminder_time.dart';
import '../../domain/entities/routine.dart';
import '../../domain/enums/reminder_enums.dart';
import '../../domain/enums/routine_category.dart';

class RoutineDraft {
  final String? existingId;
  final String name;
  final RoutineCategory category;
  final String? dosageText;
  final String? instructions;
  final String iconKey;
  final String colorKey;
  final DateTime startDate;
  final DateTime? endDate;
  final Set<int> weekdays; // 1 (Mon) .. 7 (Sun)
  final List<TimeOfDay> times;
  final ReminderSoundMode soundMode;
  final String? audioId;
  final String? audioTempPath;
  final String? existingAudioPath;
  final int? audioDurationMs;
  final int audioRevision;
  final bool vibrationEnabled;
  final bool snoozeEnabled;
  final int snoozeMinutes;

  const RoutineDraft({
    this.existingId,
    this.name = '',
    this.category = RoutineCategory.pill,
    this.dosageText,
    this.instructions,
    this.iconKey = 'pill',
    this.colorKey = 'blue',
    required this.startDate,
    this.endDate,
    this.weekdays = const {1, 2, 3, 4, 5, 6, 7},
    this.times = const [TimeOfDay(hour: 8, minute: 0)],
    this.soundMode = ReminderSoundMode.system,
    this.audioId,
    this.audioTempPath,
    this.existingAudioPath,
    this.audioDurationMs,
    this.audioRevision = 1,
    this.vibrationEnabled = true,
    this.snoozeEnabled = true,
    this.snoozeMinutes = 10,
  });

  factory RoutineDraft.initial() {
    return RoutineDraft(startDate: DateTime.now());
  }

  factory RoutineDraft.fromRoutine(Routine routine) {
    return RoutineDraft(
      existingId: routine.id,
      name: routine.name,
      category: routine.category,
      dosageText: routine.dosageText,
      instructions: routine.instructions,
      iconKey: routine.iconKey,
      colorKey: routine.colorKey,
      startDate: routine.startDate,
      endDate: routine.endDate,
      weekdays: routine.selectedWeekdays,
      times: routine.reminderTimes
          .map((t) => TimeOfDay(hour: t.hour, minute: t.minute))
          .toList(),
      soundMode: routine.soundMode,
      audioId: routine.audioId,
      existingAudioPath: routine.audioRecording?.localPath,
      audioDurationMs: routine.audioRecording?.durationMs,
      audioRevision: routine.audioRecording?.revision ?? 1,
      vibrationEnabled: routine.vibrationEnabled,
      snoozeEnabled: routine.snoozeEnabled,
      snoozeMinutes: routine.snoozeMinutes,
    );
  }

  RoutineDraft copyWith({
    String? existingId,
    String? name,
    RoutineCategory? category,
    String? dosageText,
    String? instructions,
    String? iconKey,
    String? colorKey,
    DateTime? startDate,
    DateTime? endDate,
    bool clearEndDate = false,
    Set<int>? weekdays,
    List<TimeOfDay>? times,
    ReminderSoundMode? soundMode,
    String? audioId,
    String? audioTempPath,
    String? existingAudioPath,
    int? audioDurationMs,
    int? audioRevision,
    bool? vibrationEnabled,
    bool? snoozeEnabled,
    int? snoozeMinutes,
  }) {
    return RoutineDraft(
      existingId: existingId ?? this.existingId,
      name: name ?? this.name,
      category: category ?? this.category,
      dosageText: dosageText ?? this.dosageText,
      instructions: instructions ?? this.instructions,
      iconKey: iconKey ?? this.iconKey,
      colorKey: colorKey ?? this.colorKey,
      startDate: startDate ?? this.startDate,
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
      weekdays: weekdays ?? this.weekdays,
      times: times ?? this.times,
      soundMode: soundMode ?? this.soundMode,
      audioId: audioId ?? this.audioId,
      audioTempPath: audioTempPath ?? this.audioTempPath,
      existingAudioPath: existingAudioPath ?? this.existingAudioPath,
      audioDurationMs: audioDurationMs ?? this.audioDurationMs,
      audioRevision: audioRevision ?? this.audioRevision,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    );
  }

  String? validate() {
    if (name.trim().isEmpty) {
      return 'Routine name is required';
    }
    if (name.trim().length > 60) {
      return 'Routine name must be 60 characters or less';
    }
    if (weekdays.isEmpty) {
      return 'Please select at least one day of the week';
    }
    if (times.isEmpty) {
      return 'Please add at least one reminder time';
    }

    // Check duplicate times
    final distinctTimes = <String>{};
    for (final t in times) {
      final key = '${t.hour}:${t.minute}';
      if (distinctTimes.contains(key)) {
        return 'Duplicate reminder times are not allowed (${t.formatTime()})';
      }
      distinctTimes.add(key);
    }

    if (endDate != null && endDate!.isBefore(startDate)) {
      return 'End date cannot be earlier than start date';
    }

    return null;
  }
}

extension TimeOfDayFormatting on TimeOfDay {
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
}

class SaveRoutineResult {
  final bool success;
  final String? warning;
  final Routine? routine;

  SaveRoutineResult({
    required this.success,
    this.warning,
    this.routine,
  });
}

class RoutineEditorController extends Notifier<RoutineDraft> {
  final Routine? initialRoutine;

  RoutineEditorController([this.initialRoutine]);

  @override
  RoutineDraft build() {
    if (initialRoutine != null) {
      return RoutineDraft.fromRoutine(initialRoutine!);
    }
    return RoutineDraft.initial();
  }

  void updateName(String name) => state = state.copyWith(name: name);

  void updateCategory(RoutineCategory category) {
    state = state.copyWith(
      category: category,
      iconKey: category.id,
      colorKey: category.suggestedColor,
    );
  }

  void updateDosage(String dosage) => state = state.copyWith(dosageText: dosage);
  void updateInstructions(String instructions) => state = state.copyWith(instructions: instructions);
  void updateColorKey(String colorKey) => state = state.copyWith(colorKey: colorKey);
  void updateStartDate(DateTime date) => state = state.copyWith(startDate: date);
  void updateEndDate(DateTime? date) => state = state.copyWith(endDate: date, clearEndDate: date == null);

  void toggleWeekday(int weekday) {
    final updated = Set<int>.from(state.weekdays);
    if (updated.contains(weekday)) {
      if (updated.length > 1) {
        updated.remove(weekday);
      }
    } else {
      updated.add(weekday);
    }
    state = state.copyWith(weekdays: updated);
  }

  void addTime(TimeOfDay time) {
    final updated = List<TimeOfDay>.from(state.times)..add(time);
    updated.sort((a, b) => (a.hour * 60 + a.minute).compareTo(b.hour * 60 + b.minute));
    state = state.copyWith(times: updated);
  }

  void updateTimeAt(int index, TimeOfDay newTime) {
    final updated = List<TimeOfDay>.from(state.times);
    updated[index] = newTime;
    updated.sort((a, b) => (a.hour * 60 + a.minute).compareTo(b.hour * 60 + b.minute));
    state = state.copyWith(times: updated);
  }

  void removeTimeAt(int index) {
    if (state.times.length <= 1) return;
    final updated = List<TimeOfDay>.from(state.times)..removeAt(index);
    state = state.copyWith(times: updated);
  }

  void setSoundMode(ReminderSoundMode mode) => state = state.copyWith(soundMode: mode);

  void attachRecordedVoice({
    required String tempPath,
    required int durationMs,
  }) {
    state = state.copyWith(
      soundMode: ReminderSoundMode.recorded,
      audioTempPath: tempPath,
      audioDurationMs: durationMs,
      audioRevision: state.audioRevision + 1,
    );
  }

  void removeRecordedVoice() {
    state = state.copyWith(
      soundMode: ReminderSoundMode.system,
      audioId: null,
      audioTempPath: null,
      existingAudioPath: null,
      audioDurationMs: null,
    );
  }

  void updateVibration(bool enabled) => state = state.copyWith(vibrationEnabled: enabled);
  void updateSnoozeEnabled(bool enabled) => state = state.copyWith(snoozeEnabled: enabled);
  void updateSnoozeMinutes(int minutes) => state = state.copyWith(snoozeMinutes: minutes);

  Future<SaveRoutineResult> saveRoutine() async {
    final validationError = state.validate();
    if (validationError != null) {
      return SaveRoutineResult(success: false, warning: validationError);
    }

    try {
      final routineRepo = ref.read(routineRepositoryProvider);
      final idService = ref.read(notificationIdServiceProvider);
      final audioStorage = ref.read(audioStorageServiceProvider);
      final scheduler = ref.read(reminderSchedulerProvider);

      final routineId = state.existingId ?? const Uuid().v4();
      final now = DateTime.now();

      AudioRecording? finalAudio;

      // Handle recorded audio persistence
      if (state.soundMode == ReminderSoundMode.recorded) {
        if (state.audioTempPath != null) {
          final audioId = state.audioId ?? const Uuid().v4();
          final savedPath = await audioStorage.saveRecording(
            tempPath: state.audioTempPath!,
            audioId: audioId,
            routineId: routineId,
            revision: state.audioRevision,
          );

          final iosFilename = audioStorage.getIosSoundFilename(
            routineId: routineId,
            revision: state.audioRevision,
          );

          finalAudio = AudioRecording(
            id: audioId,
            localPath: savedPath,
            iosSoundFilename: iosFilename,
            durationMs: state.audioDurationMs ?? 5000,
            revision: state.audioRevision,
            createdAt: now,
            updatedAt: now,
          );
        } else if (state.existingAudioPath != null && state.audioId != null) {
          finalAudio = AudioRecording(
            id: state.audioId!,
            localPath: state.existingAudioPath!,
            iosSoundFilename: audioStorage.getIosSoundFilename(
              routineId: routineId,
              revision: state.audioRevision,
            ),
            durationMs: state.audioDurationMs ?? 5000,
            revision: state.audioRevision,
            createdAt: now,
            updatedAt: now,
          );
        }
      }

      // Generate reminder times
      final reminderTimes = <ReminderTime>[];
      for (int i = 0; i < state.times.length; i++) {
        final t = state.times[i];
        final notifId = await idService.allocateNotificationId();
        reminderTimes.add(
          ReminderTime(
            id: const Uuid().v4(),
            routineId: routineId,
            hour: t.hour,
            minute: t.minute,
            sortOrder: i,
            isEnabled: true,
            notificationId: notifId,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }

      final routine = Routine(
        id: routineId,
        name: state.name.trim(),
        category: state.category,
        actionVerb: state.category.defaultVerb,
        dosageText: state.dosageText?.trim().isNotEmpty == true ? state.dosageText!.trim() : null,
        instructions: state.instructions?.trim().isNotEmpty == true ? state.instructions!.trim() : null,
        iconKey: state.iconKey,
        colorKey: state.colorKey,
        isActive: true,
        isArchived: false,
        startDate: state.startDate,
        endDate: state.endDate,
        weekdaysMask: Routine.maskFromWeekdays(state.weekdays),
        soundMode: state.soundMode,
        audioId: finalAudio?.id,
        vibrationEnabled: state.vibrationEnabled,
        snoozeEnabled: state.snoozeEnabled,
        snoozeMinutes: state.snoozeMinutes,
        createdAt: now,
        updatedAt: now,
        reminderTimes: reminderTimes,
        audioRecording: finalAudio,
      );

      // Save to database
      final previousRoutine = state.existingId == null
          ? null
          : await routineRepo.getById(routineId);
      await routineRepo.saveRoutine(routine);

      // Re-schedule notifications
      String? schedulerWarning;
      try {
        if (previousRoutine != null) {
          await scheduler.cancelRoutine(previousRoutine);
        }
        await scheduler.scheduleRoutine(routine);
      } catch (e) {
        AppLogger.warn('RoutineEditor', 'Scheduling failed after DB commit', e);
        schedulerWarning = 'Routine saved, but notification scheduling encountered an issue: $e';
      }

      ref.invalidate(todayOccurrencesProvider);
      return SaveRoutineResult(
        success: true,
        warning: schedulerWarning,
        routine: routine,
      );
    } catch (e, st) {
      AppLogger.error('RoutineEditor', 'Failed to save routine', e, st);
      return SaveRoutineResult(success: false, warning: 'Failed to save routine: $e');
    }
  }
}

final routineEditorControllerProvider =
    NotifierProvider.family.autoDispose<RoutineEditorController, RoutineDraft, Routine?>(
  (arg) => RoutineEditorController(arg),
);
