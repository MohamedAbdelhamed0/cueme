import 'package:flutter/material.dart';

class AppColors {
  // Brand accent primaries
  static const Color primary = Color(0xFF6366F1); // Modern Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);

  // Status colors (calm, modern)
  static const Color statusUpcoming = Color(0xFF3B82F6);
  static const Color statusDue = Color(0xFFF59E0B);
  static const Color statusDone = Color(0xFF10B981);
  static const Color statusSnoozed = Color(0xFFF97316);
  static const Color statusSkipped = Color(0xFF64748B);
  static const Color statusMissed = Color(0xFFEF4444);

  // Curated routine accent palette
  static const Map<String, Color> routinePalette = {
    'lavender': Color(0xFF9B86EE),
    'mint': Color(0xFF48BB78),
    'blue': Color(0xFF4299E1),
    'rose': Color(0xFFED64A6),
    'amber': Color(0xFFECC94B),
    'teal': Color(0xFF38B2AC),
    'indigo': Color(0xFF667EEA),
    'peach': Color(0xFFF6AD55),
  };

  static Color getColorByKey(String key) {
    return routinePalette[key.toLowerCase()] ?? const Color(0xFF6366F1);
  }

  // Light surfaces
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceSoft = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // Dark surfaces
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSurfaceSoft = Color(0xFF334155);
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
}
