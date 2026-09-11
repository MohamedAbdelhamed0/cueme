import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/service_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../domain/entities/routine.dart';
import '../../controllers/routines_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/routine_card.dart';

class RoutinesPage extends ConsumerWidget {
  const RoutinesPage({super.key});

  void _confirmDelete(BuildContext context, WidgetRef ref, Routine routine) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTokens.radiusLg)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppTokens.s24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delete "${routine.name}"?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppTokens.s8),
                Text(
                  'This will permanently remove the routine, its scheduled reminders, and any local voice recording. History will be kept.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.lightTextSecondary,
                      ),
                ),
                const SizedBox(height: AppTokens.s24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: AppTokens.s12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ref.read(routinesControllerProvider.notifier).deleteRoutine(routine);
                        },
                        style: FilledButton.styleFrom(backgroundColor: AppColors.statusMissed),
                        child: const Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final filter = ref.watch(routineFilterProvider);
    final routinesAsync = filter == RoutineFilter.active
        ? ref.watch(activeRoutinesStreamProvider)
        : ref.watch(archivedRoutinesStreamProvider);

    final controller = ref.read(routinesControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(AppTokens.s20, AppTokens.s20, AppTokens.s20, AppTokens.s12),
              child: Text(
                'My Routines',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
            ),

            // Segmented Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.s20),
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('Active'),
                    selected: filter == RoutineFilter.active,
                    onSelected: (val) {
                      if (val) ref.read(routineFilterProvider.notifier).setFilter(RoutineFilter.active);
                    },
                  ),
                  const SizedBox(width: AppTokens.s8),
                  ChoiceChip(
                    label: const Text('Archived'),
                    selected: filter == RoutineFilter.archived,
                    onSelected: (val) {
                      if (val) ref.read(routineFilterProvider.notifier).setFilter(RoutineFilter.archived);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppTokens.s12),

            // List of Routines
            Expanded(
              child: routinesAsync.when(
                data: (routines) {
                  if (routines.isEmpty) {
                    return EmptyState(
                      icon: Icons.spa_outlined,
                      title: filter == RoutineFilter.active ? 'Build your routine' : 'No archived routines',
                      description: filter == RoutineFilter.active
                          ? 'Vitamins, creams, pills, skincare — keep everything in one calm place.'
                          : 'Archived routines that are currently disabled will appear here.',
                      buttonText: filter == RoutineFilter.active ? 'Create Routine' : null,
                      onButtonPressed: () => context.push('/routine/new'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(AppTokens.s20, AppTokens.s8, AppTokens.s20, AppTokens.s48),
                    itemCount: routines.length,
                    itemBuilder: (context, index) {
                      final routine = routines[index];
                      return RoutineCard(
                        routine: routine,
                        onToggleActive: (active) => controller.toggleActive(routine),
                        onEdit: () => context.push('/routine/${routine.id}/edit'),
                        onArchive: () {
                          if (routine.isArchived) {
                            controller.unarchiveRoutine(routine);
                          } else {
                            controller.archiveRoutine(routine);
                          }
                        },
                        onDelete: () => _confirmDelete(context, ref, routine),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error loading routines: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
