import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/service_providers.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../controllers/today_controller.dart';
import '../../widgets/empty_state.dart';
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
    final occurrencesAsync = ref.watch(todayOccurrencesProvider);
    final controller = ref.read(todayControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(todayOccurrencesProvider),
          child: occurrencesAsync.when(
            data: (occurrences) {
              final completedCount = occurrences
                  .where((occurrence) => occurrence.isCompleted)
                  .length;

              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppTokens.s20,
                      AppTokens.s20,
                      AppTokens.s20,
                      0,
                    ),
                    sliver: SliverList.list(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CueMe',
                                    style: theme.textTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    DateTime.now().toFormattedDate(),
                                    style: theme.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => context.push('/settings'),
                              tooltip: 'Settings',
                              icon: const Icon(Icons.person_outline_rounded),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTokens.s16),
                        _GreetingHero(
                          greeting: _getGreeting(),
                          completed: completedCount,
                          total: occurrences.length,
                        ),
                        const SizedBox(height: AppTokens.s24),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Today’s routine',
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                            _ProgressPill(
                              completed: completedCount,
                              total: occurrences.length,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTokens.s12),
                      ],
                    ),
                  ),
                  if (occurrences.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyState(
                        icon: Icons.calendar_today_rounded,
                        title: 'Nothing scheduled yet',
                        description:
                            'Add your first routine and choose when you want to be reminded.',
                        buttonText: 'Add Routine',
                        onButtonPressed: () => context.push('/routine/new'),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        AppTokens.s20,
                        0,
                        AppTokens.s20,
                        AppTokens.s48,
                      ),
                      sliver: SliverList.separated(
                        itemCount: occurrences.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppTokens.s12),
                        itemBuilder: (context, index) {
                          final occurrence = occurrences[index];
                          return TimelineReminderRow(
                            occurrence: occurrence,
                            onDone: () => controller.markDone(occurrence),
                            onSnooze: () => controller.snooze(occurrence),
                            onSkip: () => controller.skip(occurrence),
                            onTap: () => context.push(
                              '/routine/${occurrence.routine.id}/edit',
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(AppTokens.s24),
                child: Text(
                  'Could not load today’s routines: $error',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GreetingHero extends StatelessWidget {
  const _GreetingHero({
    required this.greeting,
    required this.completed,
    required this.total,
  });

  final String greeting;
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 184,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [AppColors.darkSurfaceWarm, AppColors.darkSurface]
              : const [Color(0xFFD99B80), Color(0xFFC8795D)],
        ),
        borderRadius: AppTokens.borderRadiusXl,
        boxShadow: AppTokens.softShadow(color: AppColors.primary),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -34,
            top: 2,
            bottom: -25,
            width: 220,
            child: Image.asset(
              'assets/generated/routine_calendar_hero.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(AppTokens.s24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$greeting!',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: AppTokens.s8),
                  SizedBox(
                    width: 175,
                    child: Text(
                      total == 0
                          ? 'Let’s create your first calm daily routine.'
                          : completed == total
                          ? 'All done. You completed today’s care.'
                          : '${total - completed} ${total - completed == 1 ? 'routine' : 'routines'} left for today.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.84),
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                      ),
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
}

class _ProgressPill extends StatelessWidget {
  const _ProgressPill({required this.completed, required this.total});

  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: AppTokens.borderRadiusPill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.statusDone,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            '$completed/$total',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
