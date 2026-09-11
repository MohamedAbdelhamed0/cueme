import 'package:drift/drift.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/entities/audio_recording.dart';
import '../../domain/entities/reminder_history_entry.dart';
import '../../domain/entities/reminder_time.dart';
import '../../domain/entities/routine.dart';
import '../../domain/enums/reminder_enums.dart';
import '../../domain/enums/routine_category.dart';
import '../database/app_database.dart';
import '../database/daos/routine_dao.dart';

extension RoutineRowMapper on RoutineRow {
  Routine toDomain({
    List<ReminderTime> times = const [],
    AudioRecording? audio,
  }) {
    return Routine(
      id: id,
      name: name,
      category: RoutineCategory.fromString(category),
      actionVerb: actionVerb,
      dosageText: dosageText,
      instructions: instructions,
      iconKey: iconKey,
      colorKey: colorKey,
      isActive: isActive,
      isArchived: isArchived,
      startDate: startDate,
      endDate: endDate,
      weekdaysMask: weekdaysMask,
      soundMode: ReminderSoundMode.fromString(soundMode),
      audioId: audioId,
      vibrationEnabled: vibrationEnabled,
      snoozeEnabled: snoozeEnabled,
      snoozeMinutes: snoozeMinutes,
      createdAt: createdAt,
      updatedAt: updatedAt,
      reminderTimes: times,
      audioRecording: audio,
    );
  }
}

extension RoutineWithDetailsMapper on RoutineWithDetails {
  Routine toDomain() {
    return routine.toDomain(
      times: reminderTimes.map((t) => t.toDomain()).toList(),
      audio: audioRecording?.toDomain(),
    );
  }
}

extension RoutineEntityMapper on Routine {
  RoutinesTableCompanion toCompanion() {
    return RoutinesTableCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category.name),
      actionVerb: Value(actionVerb),
      dosageText: Value(dosageText),
      instructions: Value(instructions),
      iconKey: Value(iconKey),
      colorKey: Value(colorKey),
      isActive: Value(isActive),
      isArchived: Value(isArchived),
      startDate: Value(startDate),
      endDate: Value(endDate),
      weekdaysMask: Value(weekdaysMask),
      soundMode: Value(soundMode.name),
      audioId: Value(audioId),
      vibrationEnabled: Value(vibrationEnabled),
      snoozeEnabled: Value(snoozeEnabled),
      snoozeMinutes: Value(snoozeMinutes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension ReminderTimeRowMapper on ReminderTimeRow {
  ReminderTime toDomain() {
    return ReminderTime(
      id: id,
      routineId: routineId,
      hour: hour,
      minute: minute,
      sortOrder: sortOrder,
      isEnabled: isEnabled,
      notificationId: notificationId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ReminderTimeEntityMapper on ReminderTime {
  ReminderTimesTableCompanion toCompanion() {
    return ReminderTimesTableCompanion(
      id: Value(id),
      routineId: Value(routineId),
      hour: Value(hour),
      minute: Value(minute),
      sortOrder: Value(sortOrder),
      isEnabled: Value(isEnabled),
      notificationId: Value(notificationId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension AudioRecordingRowMapper on AudioRecordingRow {
  AudioRecording toDomain() {
    return AudioRecording(
      id: id,
      localPath: localPath,
      iosSoundFilename: iosSoundFilename,
      codec: codec,
      durationMs: durationMs,
      fileSizeBytes: fileSizeBytes,
      revision: revision,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension AudioRecordingEntityMapper on AudioRecording {
  AudioRecordingsTableCompanion toCompanion() {
    return AudioRecordingsTableCompanion(
      id: Value(id),
      localPath: Value(localPath),
      iosSoundFilename: Value(iosSoundFilename),
      codec: Value(codec),
      durationMs: Value(durationMs),
      fileSizeBytes: Value(fileSizeBytes),
      revision: Value(revision),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension ReminderHistoryRowMapper on ReminderHistoryRow {
  ReminderHistoryEntry toDomain() {
    return ReminderHistoryEntry(
      id: id,
      routineId: routineId,
      reminderTimeId: reminderTimeId,
      scheduledFor: scheduledFor,
      action: ReminderAction.fromString(action),
      actionAt: actionAt,
      snoozedUntil: snoozedUntil,
      note: note,
      createdAt: createdAt,
      routineNameSnapshot: routineNameSnapshot,
      categorySnapshot: categorySnapshot,
    );
  }
}

extension ReminderHistoryEntityMapper on ReminderHistoryEntry {
  ReminderHistoryTableCompanion toCompanion() {
    return ReminderHistoryTableCompanion(
      id: Value(id),
      routineId: Value(routineId),
      reminderTimeId: Value(reminderTimeId),
      scheduledFor: Value(scheduledFor),
      action: Value(action.name),
      actionAt: Value(actionAt),
      snoozedUntil: Value(snoozedUntil),
      note: Value(note),
      createdAt: Value(createdAt),
      routineNameSnapshot: Value(routineNameSnapshot),
      categorySnapshot: Value(categorySnapshot),
    );
  }
}

extension AppSettingsRowMapper on AppSettingsRow {
  AppSettings toDomain() {
    return AppSettings(
      id: id,
      themeMode: ThemePreference.fromString(themeMode),
      accentStyle: accentStyle,
      useDynamicColor: useDynamicColor,
      timeFormat: TimeFormatPreference.fromString(timeFormat),
      defaultSnoozeMinutes: defaultSnoozeMinutes,
      defaultVibration: defaultVibration,
      onboardingCompleted: onboardingCompleted,
      notificationEducationSeen: notificationEducationSeen,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension AppSettingsEntityMapper on AppSettings {
  AppSettingsTableCompanion toCompanion() {
    return AppSettingsTableCompanion(
      id: Value(id),
      themeMode: Value(themeMode.name),
      accentStyle: Value(accentStyle),
      useDynamicColor: Value(useDynamicColor),
      timeFormat: Value(timeFormat.name),
      defaultSnoozeMinutes: Value(defaultSnoozeMinutes),
      defaultVibration: Value(defaultVibration),
      onboardingCompleted: Value(onboardingCompleted),
      notificationEducationSeen: Value(notificationEducationSeen),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
