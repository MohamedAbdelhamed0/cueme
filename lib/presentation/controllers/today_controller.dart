import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../app/providers/service_providers.dart';
import '../../domain/entities/reminder_history_entry.dart';
import '../../domain/entities/today_occurrence.dart';
import '../../domain/enums/reminder_enums.dart';

class TodayController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> markDone(TodayOccurrence occurrence) async {
    state = const AsyncValue.loading();
    try {
      final historyRepo = ref.read(historyRepositoryProvider);
      final entry = ReminderHistoryEntry(
        id: const Uuid().v4(),
        routineId: occurrence.routine.id,
        reminderTimeId: occurrence.reminderTime.id,
        scheduledFor: occurrence.scheduledDateTime,
        action: ReminderAction.done,
        actionAt: DateTime.now(),
        createdAt: DateTime.now(),
        routineNameSnapshot: occurrence.routine.name,
        categorySnapshot: occurrence.routine.category.displayName,
      );

      await historyRepo.addEntry(entry);
      ref.invalidate(todayOccurrencesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> snooze(TodayOccurrence occurrence, [int? minutes]) async {
    state = const AsyncValue.loading();
    try {
      final snoozeDuration = minutes ?? occurrence.routine.snoozeMinutes;
      final snoozedUntil = DateTime.now().add(Duration(minutes: snoozeDuration));

      final historyRepo = ref.read(historyRepositoryProvider);
      final entry = ReminderHistoryEntry(
        id: const Uuid().v4(),
        routineId: occurrence.routine.id,
        reminderTimeId: occurrence.reminderTime.id,
        scheduledFor: occurrence.scheduledDateTime,
        action: ReminderAction.snoozed,
        actionAt: DateTime.now(),
        snoozedUntil: snoozedUntil,
        createdAt: DateTime.now(),
        routineNameSnapshot: occurrence.routine.name,
        categorySnapshot: occurrence.routine.category.displayName,
      );

      await historyRepo.addEntry(entry);
      ref.invalidate(todayOccurrencesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> skip(TodayOccurrence occurrence) async {
    state = const AsyncValue.loading();
    try {
      final historyRepo = ref.read(historyRepositoryProvider);
      final entry = ReminderHistoryEntry(
        id: const Uuid().v4(),
        routineId: occurrence.routine.id,
        reminderTimeId: occurrence.reminderTime.id,
        scheduledFor: occurrence.scheduledDateTime,
        action: ReminderAction.skipped,
        actionAt: DateTime.now(),
        createdAt: DateTime.now(),
        routineNameSnapshot: occurrence.routine.name,
        categorySnapshot: occurrence.routine.category.displayName,
      );

      await historyRepo.addEntry(entry);
      ref.invalidate(todayOccurrencesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final todayControllerProvider = NotifierProvider<TodayController, AsyncValue<void>>(TodayController.new);
