import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/service_providers.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../domain/services/occurrence_calculator.dart';
import '../../controllers/today_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/next_reminder_hero_card.dart';
import '../../widgets/progress_summary.dart';
import '../../widgets/timeline_reminder_row.dart';

class TodayPage extends ConsumerWidget {
  const TodayPage({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final occurrencesAsync = ref.watch(todayOccurrencesProvider);
    final controller = ref.read(todayControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(todayOccurrencesProvider);
          },
          child: occurrencesAsync.when(
            data: (occurrences) {
              final nextReminder = OccurrenceCalculator.findNextReminder(occurrences);
              final completedCount = occurrences.where((o) => o.isCompleted).length;
              final totalCount = occurrences.length;

              return CustomScrollView(
                slivers: [
                  // App bar / Greeting header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppTokens.s20, AppTokens.s20, AppTokens.s20, AppTokens.s12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateTime.now().toFormattedDate(),
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _getGreeting(),
                                  style: theme.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings_outlined),
                            onPressed: () => context.push('/settings'),
                            tooltip: 'Settings',
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (occurrences.isEmpty) ...[
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyState(
                        icon: Icons.calendar_today_rounded,
                        title: 'Nothing scheduled yet',
                        description: 'Add your first routine and choose when you want to be reminded.',
                        buttonText: 'Add Routine',
                        onButtonPressed: () => context.push('/routine/new'),
                      ),
                    ),
                  ] else ...[
                    // Next Reminder Hero Card
                    if (nextReminder != null)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(AppTokens.s20, AppTokens.s8, AppTokens.s20, AppTokens.s16),
                          child: NextReminderHeroCard(
                            occurrence: nextReminder,
                            onDone: () => controller.markDone(nextReminder),
                            onSnooze: () => controller.snooze(nextReminder),
                            onTap: () => context.push('/routine/${nextReminder.routine.id}/edit'),
                          ),
                        ),
                      ),

                    // Today's Progress Card
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(AppTokens.s20, 0, AppTokens.s20, AppTokens.s24),
                        child: ProgressSummary(
                          completed: completedCount,
                          total: totalCount,
                        ),
                      ),
                    ),

                    // Timeline Title
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppTokens.s20),
                        child: Text(
                          'Today\'s Timeline',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: AppTokens.s12)),

                    // Timeline items
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: AppTokens.s20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final occurrence = occurrences[index];
                            return TimelineReminderRow(
                              occurrence: occurrence,
                              onDone: () => controller.markDone(occurrence),
                              onSnooze: () => controller.snooze(occurrence),
                              onSkip: () => controller.skip(occurrence),
                              onTap: () => context.push('/routine/${occurrence.routine.id}/edit'),
                            );
                          },
                          childCount: occurrences.length,
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: AppTokens.s48)),
                  ],
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(
              child: Text('Error loading today\'s timeline: $err'),
            ),
          ),
        ),
      ),
    );
  }
}
