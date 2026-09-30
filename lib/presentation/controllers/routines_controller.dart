import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers/service_providers.dart';
import '../../domain/entities/routine.dart';

enum RoutineFilter { active, archived }

class RoutineFilterNotifier extends Notifier<RoutineFilter> {
  @override
  RoutineFilter build() => RoutineFilter.active;

  void setFilter(RoutineFilter filter) => state = filter;
}

final routineFilterProvider =
    NotifierProvider<RoutineFilterNotifier, RoutineFilter>(
      RoutineFilterNotifier.new,
    );

class RoutinesController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> toggleActive(Routine routine) async {
    state = const AsyncValue.loading();
    try {
      final newActive = !routine.isActive;
      final routineRepo = ref.read(routineRepositoryProvider);
      final scheduler = ref.read(reminderSchedulerProvider);

      await routineRepo.setActive(routine.id, newActive);

      if (newActive) {
        final updated = routine.copyWith(isActive: true);
        await scheduler.scheduleRoutine(updated);
      } else {
        await scheduler.cancelRoutine(routine);
      }

      ref.invalidate(todayOccurrencesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> archiveRoutine(Routine routine) async {
    state = const AsyncValue.loading();
    try {
      final routineRepo = ref.read(routineRepositoryProvider);
      final scheduler = ref.read(reminderSchedulerProvider);

      await routineRepo.setArchived(routine.id, true);
      await scheduler.cancelRoutine(routine);

      ref.invalidate(todayOccurrencesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> unarchiveRoutine(Routine routine) async {
    state = const AsyncValue.loading();
    try {
      final routineRepo = ref.read(routineRepositoryProvider);
      final scheduler = ref.read(reminderSchedulerProvider);

      await routineRepo.setArchived(routine.id, false);
      final updated = routine.copyWith(isArchived: false, isActive: true);
      await scheduler.scheduleRoutine(updated);

      ref.invalidate(todayOccurrencesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteRoutine(Routine routine) async {
    state = const AsyncValue.loading();
    try {
      final routineRepo = ref.read(routineRepositoryProvider);
      final scheduler = ref.read(reminderSchedulerProvider);
      final audioStorage = ref.read(audioStorageServiceProvider);

      // Hide from reconciliation before cancellation and audio cleanup.
      await routineRepo.setActive(routine.id, false);
      await scheduler.cancelRoutine(routine);

      // 2. Delete local audio recording if exists
      if (routine.audioId != null) {
        await audioStorage.deleteAudio(
          audioId: routine.audioId!,
          iosSoundFilename: routine.audioRecording?.iosSoundFilename,
        );
      }

      // 3. Delete database record
      await routineRepo.deleteRoutine(routine.id);

      ref.invalidate(todayOccurrencesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final routinesControllerProvider =
    NotifierProvider<RoutinesController, AsyncValue<void>>(
      RoutinesController.new,
    );
