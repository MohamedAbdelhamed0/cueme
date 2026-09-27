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

  Color _statusColor(OccurrenceStatus status) => switch (status) {
    OccurrenceStatus.upcoming => AppColors.statusUpcoming,
    OccurrenceStatus.due => AppColors.statusDue,
    OccurrenceStatus.done => AppColors.statusDone,
    OccurrenceStatus.snoozed => AppColors.statusSnoozed,
    OccurrenceStatus.skipped => AppColors.statusSkipped,
    OccurrenceStatus.missed => AppColors.statusMissed,
  };

  String _statusLabel(OccurrenceStatus status) => switch (status) {
    OccurrenceStatus.upcoming => 'Upcoming',
    OccurrenceStatus.due => 'Due now',
    OccurrenceStatus.done => 'Done',
    OccurrenceStatus.snoozed => 'Snoozed',
    OccurrenceStatus.skipped => 'Skipped',
    OccurrenceStatus.missed => 'Missed',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final routine = occurrence.routine;
    final routineColor = AppColors.getColorByKey(routine.colorKey);
    final statusColor = _statusColor(occurrence.status);
    final finished =
        occurrence.status == OccurrenceStatus.done ||
        occurrence.status == OccurrenceStatus.skipped;
    final secondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTokens.borderRadiusLg,
        child: Container(
          padding: const EdgeInsets.all(AppTokens.s14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: AppTokens.borderRadiusLg,
            boxShadow: AppTokens.softShadow(),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: routineColor.withValues(alpha: 0.13),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  routine.category.assetPath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: AppTokens.s14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            routine.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              decoration: finished
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: finished ? secondary : null,
                            ),
                          ),
                        ),
                        if (routine.soundMode ==
                            ReminderSoundMode.recorded) ...[
                          const SizedBox(width: 6),
                          Icon(
                            Icons.mic_rounded,
                            size: 14,
                            color: routineColor,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      [
                        occurrence.scheduledDateTime.toFormattedTime(),
                        if (routine.dosageText?.isNotEmpty == true)
                          routine.dosageText!,
                      ].join('  ·  '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: secondary,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.13),
                        borderRadius: AppTokens.borderRadiusPill,
                      ),
                      child: Text(
                        _statusLabel(occurrence.status),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!finished)
                IconButton(
                  onPressed: onDone,
                  tooltip: 'Mark Done',
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTokens.borderRadiusSm,
                    ),
                  ),
                  icon: const Icon(Icons.check_rounded, size: 20),
                )
              else
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.13),
                    borderRadius: AppTokens.borderRadiusSm,
                  ),
                  child: Icon(
                    occurrence.status == OccurrenceStatus.done
                        ? Icons.check_rounded
                        : Icons.close_rounded,
                    color: statusColor,
                  ),
                ),
              if (!finished)
                PopupMenuButton<String>(
                  tooltip: 'Reminder options',
                  icon: const Icon(Icons.more_vert_rounded),
                  onSelected: (value) {
                    if (value == 'snooze') onSnooze();
                    if (value == 'skip') onSkip();
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'snooze', child: Text('Snooze')),
                    PopupMenuItem(value: 'skip', child: Text('Skip this time')),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
