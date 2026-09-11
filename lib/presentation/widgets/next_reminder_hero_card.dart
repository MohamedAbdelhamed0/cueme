import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/extensions/date_time_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';
import '../../domain/entities/today_occurrence.dart';
import '../../domain/enums/reminder_enums.dart';

class NextReminderHeroCard extends StatefulWidget {
  final TodayOccurrence occurrence;
  final VoidCallback onDone;
  final VoidCallback onSnooze;
  final VoidCallback onTap;

  const NextReminderHeroCard({
    super.key,
    required this.occurrence,
    required this.onDone,
    required this.onSnooze,
    required this.onTap,
  });

  @override
  State<NextReminderHeroCard> createState() => _NextReminderHeroCardState();
}

class _NextReminderHeroCardState extends State<NextReminderHeroCard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Refresh countdown every 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatCountdown(DateTime scheduled) {
    final now = DateTime.now();
    final diff = scheduled.difference(now);

    if (diff.isNegative) {
      final passed = now.difference(scheduled);
      if (passed.inMinutes < 60) {
        return 'Due ${passed.inMinutes}m ago';
      }
      return 'Due now';
    }

    if (diff.inMinutes < 1) {
      return 'Due in moments';
    }
    if (diff.inHours < 1) {
      return 'in ${diff.inMinutes}m';
    }
    if (diff.inHours < 24) {
      final remMins = diff.inMinutes % 60;
      return 'in ${diff.inHours}h ${remMins > 0 ? "${remMins}m" : ""}';
    }
    return 'Upcoming';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final routine = widget.occurrence.routine;
    final routineColor = AppColors.getColorByKey(routine.colorKey);
    final isDue = widget.occurrence.status == OccurrenceStatus.due;
    final countdown = _formatCountdown(widget.occurrence.scheduledDateTime);

    return InkWell(
      onTap: widget.onTap,
      borderRadius: AppTokens.borderRadiusXl,
      child: Container(
        padding: const EdgeInsets.all(AppTokens.s24),
        decoration: BoxDecoration(
          borderRadius: AppTokens.borderRadiusXl,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    routineColor.withValues(alpha: 0.25),
                    AppColors.darkSurface,
                  ]
                : [
                    routineColor.withValues(alpha: 0.18),
                    AppColors.lightSurface,
                  ],
          ),
          border: Border.all(
            color: routineColor.withValues(alpha: isDark ? 0.4 : 0.3),
            width: 1.5,
          ),
          boxShadow: AppTokens.softShadow(color: routineColor.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isDue ? AppColors.statusDue : routineColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isDue ? Icons.notifications_active_rounded : Icons.schedule_rounded,
                        size: 14,
                        color: isDue ? Colors.white : routineColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isDue ? 'Due Now' : countdown,
                        style: TextStyle(
                          color: isDue ? Colors.white : routineColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  widget.occurrence.scheduledDateTime.toFormattedTime(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.s16),
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: routineColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    routine.category.icon,
                    size: 28,
                    color: routineColor,
                  ),
                ),
                const SizedBox(width: AppTokens.s16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        routine.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      if (routine.dosageText != null || routine.instructions != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          [
                            if (routine.dosageText != null) routine.dosageText,
                            if (routine.instructions != null) routine.instructions,
                          ].join(' • '),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (isDue) ...[
              const SizedBox(height: AppTokens.s20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: widget.onDone,
                      icon: const Icon(Icons.check_rounded, size: 20),
                      label: Text('Mark ${routine.verb}'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.statusDone,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: AppTokens.borderRadiusMd),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTokens.s12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: widget.onSnooze,
                      icon: const Icon(Icons.snooze_rounded, size: 18),
                      label: const Text('Snooze'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: AppTokens.borderRadiusMd),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
