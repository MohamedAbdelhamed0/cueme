import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/date_time_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../domain/entities/reminder_history_entry.dart';
import '../../../domain/enums/reminder_enums.dart';
import '../../controllers/history_controller.dart';
import '../../widgets/empty_state.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  Widget _buildGroup(BuildContext context, String title, List<ReminderHistoryEntry> entries) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.s20, vertical: AppTokens.s12),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...entries.map((entry) {
          final isDone = entry.action == ReminderAction.done;
          final isSkipped = entry.action == ReminderAction.skipped;
          final isSnoozed = entry.action == ReminderAction.snoozed;

          final statusColor = isDone
              ? AppColors.statusDone
              : (isSnoozed
                  ? AppColors.statusSnoozed
                  : (isSkipped ? AppColors.statusSkipped : AppColors.statusMissed));

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppTokens.s20, vertical: 4),
            padding: const EdgeInsets.all(AppTokens.s14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: AppTokens.borderRadiusMd,
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDone
                        ? Icons.check_circle_rounded
                        : (isSnoozed
                            ? Icons.snooze_rounded
                            : (isSkipped ? Icons.close_rounded : Icons.warning_amber_rounded)),
                    color: statusColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppTokens.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.routineNameSnapshot ?? 'Routine Reminder',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Scheduled: ${entry.scheduledFor.toFormattedTime()}${entry.actionAt != null ? " • Action: ${entry.actionAt!.toFormattedTime()}" : ""}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    entry.action.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final groupedAsync = ref.watch(groupedHistoryProvider);
    final filterAction = ref.watch(historyFilterActionProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(AppTokens.s20, AppTokens.s20, AppTokens.s20, AppTokens.s12),
              child: Text(
                'History',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
            ),

            // Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.s20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: filterAction == null,
                      onSelected: (val) {
                        if (val) ref.read(historyFilterActionProvider.notifier).setFilter(null);
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Done'),
                      selected: filterAction == ReminderAction.done,
                      onSelected: (val) {
                        if (val) ref.read(historyFilterActionProvider.notifier).setFilter(ReminderAction.done);
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Snoozed'),
                      selected: filterAction == ReminderAction.snoozed,
                      onSelected: (val) {
                        if (val) ref.read(historyFilterActionProvider.notifier).setFilter(ReminderAction.snoozed);
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Skipped'),
                      selected: filterAction == ReminderAction.skipped,
                      onSelected: (val) {
                        if (val) ref.read(historyFilterActionProvider.notifier).setFilter(ReminderAction.skipped);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppTokens.s12),

            Expanded(
              child: groupedAsync.when(
                data: (grouped) {
                  if (grouped.isEmpty) {
                    return const EmptyState(
                      icon: Icons.history_rounded,
                      title: 'No activity yet',
                      description: 'Completed and skipped reminders will appear here.',
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.only(bottom: AppTokens.s48),
                    children: [
                      _buildGroup(context, 'Today', grouped.today),
                      _buildGroup(context, 'Yesterday', grouped.yesterday),
                      _buildGroup(context, 'This Week', grouped.thisWeek),
                      _buildGroup(context, 'Earlier', grouped.earlier),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error loading history: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
