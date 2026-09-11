import 'package:flutter/material.dart';
import '../../core/extensions/date_time_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';
import '../../domain/entities/today_occurrence.dart';
import '../../domain/enums/reminder_enums.dart';

class TimelineReminderRow extends StatelessWidget {
  final TodayOccurrence occurrence;
  final VoidCallback onDone;
  final VoidCallback onSnooze;
  final VoidCallback onSkip;
  final VoidCallback onTap;

  const TimelineReminderRow({
    super.key,
    required this.occurrence,
    required this.onDone,
    required this.onSnooze,
    required this.onSkip,
    required this.onTap,
  });

  Color _getStatusColor(OccurrenceStatus status) {
    switch (status) {
      case OccurrenceStatus.upcoming:
        return AppColors.statusUpcoming;
      case OccurrenceStatus.due:
        return AppColors.statusDue;
      case OccurrenceStatus.done:
        return AppColors.statusDone;
      case OccurrenceStatus.snoozed:
        return AppColors.statusSnoozed;
      case OccurrenceStatus.skipped:
        return AppColors.statusSkipped;
      case OccurrenceStatus.missed:
        return AppColors.statusMissed;
    }
  }

  String _getStatusLabel(OccurrenceStatus status) {
    switch (status) {
      case OccurrenceStatus.upcoming:
        return 'Upcoming';
      case OccurrenceStatus.due:
        return 'Due';
      case OccurrenceStatus.done:
        return 'Done';
      case OccurrenceStatus.snoozed:
        return 'Snoozed';
      case OccurrenceStatus.skipped:
        return 'Skipped';
      case OccurrenceStatus.missed:
        return 'Missed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final routine = occurrence.routine;
    final routineColor = AppColors.getColorByKey(routine.colorKey);
    final statusColor = _getStatusColor(occurrence.status);
    final isDone = occurrence.status == OccurrenceStatus.done;
    final isSkipped = occurrence.status == OccurrenceStatus.skipped;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTokens.s12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: AppTokens.borderRadiusLg,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: AppTokens.softShadow(),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTokens.borderRadiusLg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.s16, vertical: AppTokens.s14),
          child: Row(
            children: [
              // Time and vertical indicator
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    occurrence.scheduledDateTime.toFormattedTime(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isDone || isSkipped
                          ? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _getStatusLabel(occurrence.status),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppTokens.s16),
              // Category Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: routineColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  routine.category.icon,
                  size: 22,
                  color: routineColor,
                ),
              ),
              const SizedBox(width: AppTokens.s12),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            routine.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              decoration: isDone || isSkipped ? TextDecoration.lineThrough : null,
                              color: isDone || isSkipped
                                  ? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (routine.soundMode == ReminderSoundMode.recorded) ...[
                          const SizedBox(width: 6),
                          Icon(
                            Icons.mic_rounded,
                            size: 14,
                            color: routineColor,
                          ),
                        ],
                      ],
                    ),
                    if (routine.dosageText != null || routine.instructions != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        [
                          if (routine.dosageText != null) routine.dosageText,
                          if (routine.instructions != null) routine.instructions,
                        ].join(' • '),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Quick action
              if (!isDone && !isSkipped) ...[
                IconButton(
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  color: AppColors.statusDone,
                  tooltip: 'Mark Done',
                  onPressed: onDone,
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert_rounded, size: 20),
                  onSelected: (val) {
                    if (val == 'snooze') onSnooze();
                    if (val == 'skip') onSkip();
                  },
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: 'snooze',
                      child: Row(
                        children: [
                          Icon(Icons.snooze_rounded, size: 18),
                          SizedBox(width: 8),
                          Text('Snooze'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'skip',
                      child: Row(
                        children: [
                          Icon(Icons.close_rounded, size: 18),
                          SizedBox(width: 8),
                          Text('Skip'),
                        ],
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Icon(
                  isDone ? Icons.check_circle_rounded : Icons.cancel_outlined,
                  color: isDone ? AppColors.statusDone : AppColors.statusSkipped,
                  size: 24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
