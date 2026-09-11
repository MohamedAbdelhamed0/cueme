import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';

class WeekdaySelector extends StatelessWidget {
  final Set<int> selectedWeekdays;
  final ValueChanged<int> onDayToggled;

  const WeekdaySelector({
    super.key,
    required this.selectedWeekdays,
    required this.onDayToggled,
  });

  static const _days = [
    (1, 'M', 'Mon'),
    (2, 'T', 'Tue'),
    (3, 'W', 'Wed'),
    (4, 'T', 'Thu'),
    (5, 'F', 'Fri'),
    (6, 'S', 'Sat'),
    (7, 'S', 'Sun'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _days.map((day) {
        final (index, letter, _) = day;
        final isSelected = selectedWeekdays.contains(index);

        return GestureDetector(
          onTap: () => onDayToggled(index),
          child: AnimatedContainer(
            duration: AppTokens.durationFast,
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : (isDark ? AppColors.darkSurfaceSoft : AppColors.lightSurfaceSoft),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              letter,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
