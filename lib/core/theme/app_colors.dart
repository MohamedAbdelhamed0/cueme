import 'package:flutter/material.dart';

/// CueMe's warm wellness palette.
class AppColors {
  static const Color primary = Color(0xFFC9795C);
  static const Color primaryLight = Color(0xFFE5A487);
  static const Color primaryDark = Color(0xFF9E533C);
  static const Color accent = Color(0xFFF1B85B);
  static const Color ink = Color(0xFF20263D);

  static const Color statusUpcoming = Color(0xFF7B91A8);
  static const Color statusDue = Color(0xFFE7A94D);
  static const Color statusDone = Color(0xFF72A58A);
  static const Color statusSnoozed = Color(0xFFD38B62);
  static const Color statusSkipped = Color(0xFF8E8A86);
  static const Color statusMissed = Color(0xFFC65F5A);

  static const Map<String, Color> routinePalette = {
    'lavender': Color(0xFFA89CC8),
    'mint': Color(0xFF83AD96),
    'blue': Color(0xFF82A5B8),
    'rose': Color(0xFFC9827F),
    'amber': Color(0xFFE4AF59),
    'teal': Color(0xFF75A5A0),
    'indigo': Color(0xFF7E87AA),
    'peach': Color(0xFFE5A487),
  };

  static Color getColorByKey(String key) {
    return routinePalette[key.toLowerCase()] ?? primary;
  }

  static const Color lightBackground = Color(0xFFF6EEE7);
  static const Color lightSurface = Color(0xFFFFFCF9);
  static const Color lightSurfaceSoft = Color(0xFFF3E8DF);
  static const Color lightSurfaceWarm = Color(0xFFE8C7B6);
  static const Color lightBorder = Color(0xFFE8DDD5);
  static const Color lightTextPrimary = ink;
  static const Color lightTextSecondary = Color(0xFF77716D);

  static const Color darkBackground = Color(0xFF171820);
  static const Color darkSurface = Color(0xFF23242D);
  static const Color darkSurfaceSoft = Color(0xFF2F303A);
  static const Color darkSurfaceWarm = Color(0xFF684B42);
  static const Color darkBorder = Color(0xFF3B3A42);
  static const Color darkTextPrimary = Color(0xFFFFF9F4);
  static const Color darkTextSecondary = Color(0xFFC2B9B2);
}
