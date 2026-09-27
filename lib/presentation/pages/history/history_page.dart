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

  static const _filters = <(String, ReminderAction?)>[
    ('All', null),
    ('Done', ReminderAction.done),
    ('Snoozed', ReminderAction.snoozed),
    ('Skipped', ReminderAction.skipped),
  ];

  Widget _buildFilters(
    BuildContext context,
    WidgetRef ref,
    ReminderAction? selected,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTokens.s20),
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppTokens.s8),
        itemBuilder: (context, index) {
          final (label, action) = _filters[index];
          final isSelected = selected == action;
          return ChoiceChip(
            label: Text(label),
            selected: isSelected,
            onSelected: (_) => ref
                .read(historyFilterActionProvider.notifier)
                .setFilter(action),
            showCheckmark: false,
            labelStyle: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
              fontWeight: FontWeight.w700,
            ),
            selectedColor: AppColors.ink,
            backgroundColor: isDark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
            side: BorderSide.none,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: AppTokens.s12),
          );
        },
      ),
    );
  }

  Widget _buildHero(BuildContext context, int total) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 164,
      margin: const EdgeInsets.fromLTRB(
        AppTokens.s20,
        AppTokens.s8,
        AppTokens.s20,
        AppTokens.s20,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? const [Color(0xFF62493F), Color(0xFF3B3030)]
              : const [Color(0xFFE7B49E), Color(0xFFF2D5C4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppTokens.borderRadiusXl,
        boxShadow: AppTokens.softShadow(),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -23,
            width: 176,
            height: 176,
            child: Image.asset(
              'assets/generated/category_custom.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(AppTokens.s24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'YOUR JOURNEY',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.ink.withValues(alpha: 0.62),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppTokens.s8),
                  Text(
                    total == 0
                        ? 'Small steps add up'
                        : '$total moments\nremembered',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.ink,
                      height: 1.05,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.7,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Keep caring for your future self.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.ink.withValues(alpha: 0.68),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroup(
    BuildContext context,
    String title,
    List<ReminderHistoryEntry> entries,
  ) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTokens.s20,
        AppTokens.s20,
        AppTokens.s20,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(width: AppTokens.s8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: AppTokens.borderRadiusPill,
                ),
                child: Text(
                  '${entries.length}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.s12),
          ...entries.map((entry) => _HistoryCard(entry: entry, isDark: isDark)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final groupedAsync = ref.watch(groupedHistoryProvider);
    final selectedFilter = ref.watch(historyFilterActionProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppTokens.s20,
                AppTokens.s20,
                AppTokens.s20,
                AppTokens.s8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CueMe',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Activity history',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.9,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: groupedAsync.when(
                data: (grouped) {
                  final total =
                      grouped.today.length +
                      grouped.yesterday.length +
                      grouped.thisWeek.length +
                      grouped.earlier.length;

                  return ListView(
                    padding: const EdgeInsets.only(bottom: AppTokens.s48),
                    children: [
                      _buildHero(context, total),
                      _buildFilters(context, ref, selectedFilter),
                      if (grouped.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: AppTokens.s32),
                          child: EmptyState(
                            icon: Icons.history_rounded,
                            title: 'No activity yet',
                            description:
                                'Completed and skipped reminders will appear here.',
                          ),
                        )
                      else ...[
                        _buildGroup(context, 'Today', grouped.today),
                        _buildGroup(context, 'Yesterday', grouped.yesterday),
                        _buildGroup(context, 'This week', grouped.thisWeek),
                        _buildGroup(context, 'Earlier', grouped.earlier),
                      ],
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTokens.s24),
                    child: Text('Error loading history: $err'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.entry, required this.isDark});

  final ReminderHistoryEntry entry;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDone = entry.action == ReminderAction.done;
    final isSnoozed = entry.action == ReminderAction.snoozed;
    final isSkipped = entry.action == ReminderAction.skipped;
    final statusColor = isDone
        ? AppColors.statusDone
        : isSnoozed
        ? AppColors.statusSnoozed
        : isSkipped
        ? AppColors.statusSkipped
        : AppColors.statusMissed;
    final statusIcon = isDone
        ? Icons.check_rounded
        : isSnoozed
        ? Icons.snooze_rounded
        : isSkipped
        ? Icons.close_rounded
        : Icons.priority_high_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTokens.s12),
      padding: const EdgeInsets.all(AppTokens.s12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: AppTokens.borderRadiusLg,
        boxShadow: AppTokens.softShadow(),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurfaceSoft
                  : AppColors.lightSurfaceSoft,
              borderRadius: AppTokens.borderRadiusMd,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      'assets/generated/routine_capsule.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkSurface
                            : AppColors.lightSurface,
                        width: 2,
                      ),
                    ),
                    child: Icon(statusIcon, color: Colors.white, size: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTokens.s14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.routineNameSnapshot ?? 'Routine reminder',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Scheduled ${entry.scheduledFor.toFormattedTime()}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                if (entry.actionAt != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Action ${entry.actionAt!.toFormattedTime()}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppTokens.s8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.13),
              borderRadius: AppTokens.borderRadiusPill,
            ),
            child: Text(
              entry.action.name.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
