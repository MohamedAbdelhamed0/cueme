enum ReminderSoundMode {
  recorded,
  system,
  silent;

  static ReminderSoundMode fromString(String? value) {
    if (value == null) return ReminderSoundMode.system;
    for (final mode in ReminderSoundMode.values) {
      if (mode.name == value.toLowerCase()) return mode;
    }
    return ReminderSoundMode.system;
  }
}

enum ReminderAction {
  done,
  skipped,
  snoozed,
  missed;

  static ReminderAction fromString(String? value) {
    if (value == null) return ReminderAction.done;
    for (final action in ReminderAction.values) {
      if (action.name == value.toLowerCase()) return action;
    }
    return ReminderAction.done;
  }
}

enum ThemePreference {
  system,
  light,
  dark;

  static ThemePreference fromString(String? value) {
    if (value == null) return ThemePreference.system;
    for (final pref in ThemePreference.values) {
      if (pref.name == value.toLowerCase()) return pref;
    }
    return ThemePreference.system;
  }
}

enum TimeFormatPreference {
  system,
  twelveHour,
  twentyFourHour;

  static TimeFormatPreference fromString(String? value) {
    if (value == null) return TimeFormatPreference.system;
    for (final pref in TimeFormatPreference.values) {
      if (pref.name == value.toLowerCase()) return pref;
    }
    return TimeFormatPreference.system;
  }
}

enum ExactAlarmCapability {
  available,
  needsPermission,
  unavailable,
}

enum OccurrenceStatus {
  upcoming,
  due,
  done,
  snoozed,
  skipped,
  missed,
}
