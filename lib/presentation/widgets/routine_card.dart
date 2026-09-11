import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';
import '../../domain/entities/routine.dart';
import '../../domain/enums/reminder_enums.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final ValueChanged<bool> onToggleActive;
  final VoidCallback onEdit;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  const RoutineCard({
    super.key,
    required this.routine,
    required this.onToggleActive,
    required this.onEdit,
    required this.onArchive,
    required this.onDelete,
  });

  String _formatDays(Routine r) {
    if (r.weekdaysMask == 127) return 'Every day';
    if (r.weekdaysMask == 31) return 'Mon–Fri';
    if (r.weekdaysMask == 96) return 'Weekends';

    const dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final active = <String>[];
    for (int i = 1; i <= 7; i++) {
      if (r.isScheduledForWeekday(i)) {
        active.add(dayLabels[i - 1]);
      }
    }
    return active.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final routineColor = AppColors.getColorByKey(routine.colorKey);
    final timesCount = routine.reminderTimes.where((t) => t.isEnabled).length;
    final timesLabel = timesCount == 1 ? '1 time per day' : '$timesCount times per day';

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
        onTap: onEdit,
        borderRadius: AppTokens.borderRadiusLg,
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: routineColor.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      routine.category.icon,
                      size: 24,
                      color: routineColor,
                    ),
                  ),
                  const SizedBox(width: AppTokens.s12),
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
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (routine.soundMode == ReminderSoundMode.recorded) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: routineColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.mic_rounded, size: 12, color: routineColor),
                                    const SizedBox(width: 3),
                                    Text(
                                      'Voice',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: routineColor,
                                      ),
                                    ),
                                  ],
                                ),
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
                  Switch.adaptive(
                    value: routine.isActive,
                    activeTrackColor: AppColors.primary,
                    onChanged: routine.isArchived ? null : onToggleActive,
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.s12),
              const Divider(height: 1),
              const SizedBox(height: AppTokens.s12),
              Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 15,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    timesLabel,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(width: AppTokens.s16),
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _formatDays(routine),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded, size: 20),
                    onSelected: (val) {
                      if (val == 'edit') onEdit();
                      if (val == 'archive') onArchive();
                      if (val == 'delete') onDelete();
                    },
                    itemBuilder: (ctx) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 18),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'archive',
                        child: Row(
                          children: [
                            Icon(
                              routine.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(routine.isArchived ? 'Unarchive' : 'Archive'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.statusMissed),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: AppColors.statusMissed)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
