import '../enums/reminder_enums.dart';

class AppSettings {
  final int id;
  final ThemePreference themeMode;
  final String accentStyle;
  final bool useDynamicColor;
  final TimeFormatPreference timeFormat;
  final int defaultSnoozeMinutes;
  final bool defaultVibration;
  final bool onboardingCompleted;
  final bool notificationEducationSeen;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AppSettings({
    this.id = 1,
    this.themeMode = ThemePreference.system,
    this.accentStyle = 'default',
    this.useDynamicColor = false,
    this.timeFormat = TimeFormatPreference.system,
    this.defaultSnoozeMinutes = 10,
    this.defaultVibration = true,
    this.onboardingCompleted = false,
    this.notificationEducationSeen = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppSettings.defaults() {
    final now = DateTime.now();
    return AppSettings(
      createdAt: now,
      updatedAt: now,
    );
  }

  AppSettings copyWith({
    int? id,
    ThemePreference? themeMode,
    String? accentStyle,
    bool? useDynamicColor,
    TimeFormatPreference? timeFormat,
    int? defaultSnoozeMinutes,
    bool? defaultVibration,
    bool? onboardingCompleted,
    bool? notificationEducationSeen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppSettings(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      accentStyle: accentStyle ?? this.accentStyle,
      useDynamicColor: useDynamicColor ?? this.useDynamicColor,
      timeFormat: timeFormat ?? this.timeFormat,
      defaultSnoozeMinutes: defaultSnoozeMinutes ?? this.defaultSnoozeMinutes,
      defaultVibration: defaultVibration ?? this.defaultVibration,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      notificationEducationSeen: notificationEducationSeen ?? this.notificationEducationSeen,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
