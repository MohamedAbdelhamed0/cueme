import 'package:flutter/material.dart';

enum RoutineCategory {
  pill('pill', 'Pill', 'Take', Icons.medication_outlined, 'blue'),
  medicine('medicine', 'Medicine', 'Take', Icons.healing_outlined, 'rose'),
  vitamin('vitamin', 'Vitamin', 'Take', Icons.local_florist_outlined, 'amber'),
  supplement('supplement', 'Supplement', 'Take', Icons.fitness_center_outlined, 'teal'),
  cream('cream', 'Cream', 'Apply', Icons.spa_outlined, 'lavender'),
  skincare('skincare', 'Skincare', 'Apply', Icons.water_drop_outlined, 'mint'),
  drops('drops', 'Drops', 'Use', Icons.opacity_outlined, 'indigo'),
  custom('custom', 'Custom', 'Do', Icons.star_outline, 'peach');

  final String id;
  final String displayName;
  final String defaultVerb;
  final IconData icon;
  final String suggestedColor;

  const RoutineCategory(
    this.id,
    this.displayName,
    this.defaultVerb,
    this.icon,
    this.suggestedColor,
  );

  static RoutineCategory fromString(String? value) {
    if (value == null) return RoutineCategory.custom;
    for (final category in RoutineCategory.values) {
      if (category.id == value.toLowerCase() || category.name == value.toLowerCase()) {
        return category;
      }
    }
    return RoutineCategory.custom;
  }
}
