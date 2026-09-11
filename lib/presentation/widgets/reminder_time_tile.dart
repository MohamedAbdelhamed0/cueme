import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';
import '../controllers/routine_editor_controller.dart';

class ReminderTimeTile extends StatelessWidget {
  final TimeOfDay time;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const ReminderTimeTile({
    super.key,
    required this.time,
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTokens.s8),
      padding: const EdgeInsets.symmetric(horizontal: AppTokens.s16, vertical: AppTokens.s12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceSoft : AppColors.lightSurfaceSoft,
        borderRadius: AppTokens.borderRadiusMd,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time_rounded, size: 20, color: AppColors.primary),
          const SizedBox(width: AppTokens.s12),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                time.formatTime(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
          const Spacer(),
          if (onRemove != null)
            IconButton(
              icon: const Icon(Icons.remove_circle_outline_rounded, size: 20),
              color: AppColors.statusMissed,
              tooltip: 'Remove time',
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
