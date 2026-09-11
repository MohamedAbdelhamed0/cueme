import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cueme/presentation/controllers/routine_editor_controller.dart';

void main() {
  group('RoutineDraft Validation Tests', () {
    test('Valid draft passes validation', () {
      final draft = RoutineDraft(
        name: 'Vitamin C',
        startDate: DateTime(2026, 9, 1),
        weekdays: {1, 2, 3},
        times: const [TimeOfDay(hour: 8, minute: 0)],
      );

      expect(draft.validate(), isNull);
    });

    test('Empty or whitespace name fails validation', () {
      final draft = RoutineDraft(
        name: '   ',
        startDate: DateTime(2026, 9, 1),
      );

      expect(draft.validate(), contains('Routine name is required'));
    });

    test('Name longer than 60 chars fails validation', () {
      final draft = RoutineDraft(
        name: 'A' * 61,
        startDate: DateTime(2026, 9, 1),
      );

      expect(draft.validate(), contains('60 characters or less'));
    });

    test('Empty weekdays fails validation', () {
      final draft = RoutineDraft(
        name: 'Moisturizer',
        startDate: DateTime(2026, 9, 1),
        weekdays: {},
      );

      expect(draft.validate(), contains('select at least one day'));
    });

    test('Empty times fails validation', () {
      final draft = RoutineDraft(
        name: 'Moisturizer',
        startDate: DateTime(2026, 9, 1),
        times: [],
      );

      expect(draft.validate(), contains('at least one reminder time'));
    });

    test('Duplicate times fails validation', () {
      final draft = RoutineDraft(
        name: 'Moisturizer',
        startDate: DateTime(2026, 9, 1),
        times: const [
          TimeOfDay(hour: 9, minute: 0),
          TimeOfDay(hour: 9, minute: 0),
        ],
      );

      expect(draft.validate(), contains('Duplicate reminder times are not allowed'));
    });

    test('End date before start date fails validation', () {
      final draft = RoutineDraft(
        name: 'Antibiotics',
        startDate: DateTime(2026, 9, 10),
        endDate: DateTime(2026, 9, 5),
      );

      expect(draft.validate(), contains('End date cannot be earlier than start date'));
    });
  });
}
