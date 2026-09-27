import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/providers/service_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../domain/entities/routine.dart';
import '../../controllers/routines_controller.dart';
import '../../widgets/empty_state.dart';

class RoutinesPage extends ConsumerStatefulWidget {
  const RoutinesPage({super.key});

  @override
  ConsumerState<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends ConsumerState<RoutinesPage> {
  late DateTime _selectedDate;
  late DateTime _visibleMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _visibleMonth = DateTime(now.year, now.month);
  }

  bool _routineRunsOn(Routine routine, DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final start = DateTime(
      routine.startDate.year,
      routine.startDate.month,
      routine.startDate.day,
    );
    final end = routine.endDate == null
        ? null
        : DateTime(
            routine.endDate!.year,
            routine.endDate!.month,
            routine.endDate!.day,
          );
    return !day.isBefore(start) &&
        (end == null || !day.isAfter(end)) &&
        routine.isScheduledForWeekday(day.weekday);
  }

  void _changeMonth(int delta) {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta);
      _selectedDate = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    });
  }

  void _confirmDelete(BuildContext context, Routine routine) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppTokens.s24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delete “${routine.name}”?',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: AppTokens.s8),
                Text(
                  'This removes the routine, scheduled reminders, and its local voice recording. History is kept.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: AppTokens.s24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: AppTokens.s12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ref
                              .read(routinesControllerProvider.notifier)
                              .deleteRoutine(routine);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.statusMissed,
                        ),
                        child: const Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filter = ref.watch(routineFilterProvider);
    final routinesAsync = filter == RoutineFilter.active
        ? ref.watch(activeRoutinesStreamProvider)
        : ref.watch(archivedRoutinesStreamProvider);

    return Scaffold(
      body: SafeArea(
        child: routinesAsync.when(
          data: (routines) => _buildContent(context, routines, filter),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(AppTokens.s24),
              child: Text(
                'Could not load routines: $error',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<Routine> routines,
    RoutineFilter filter,
  ) {
    final theme = Theme.of(context);
    final selectedRoutines = filter == RoutineFilter.active
        ? routines
              .where((routine) => _routineRunsOn(routine, _selectedDate))
              .toList()
        : routines;

    selectedRoutines.sort((a, b) {
      final aTime = a.reminderTimes.where((time) => time.isEnabled).firstOrNull;
      final bTime = b.reminderTimes.where((time) => time.isEnabled).firstOrNull;
      final aMinutes = aTime == null ? 1440 : aTime.hour * 60 + aTime.minute;
      final bMinutes = bTime == null ? 1440 : bTime.hour * 60 + bTime.minute;
      return aMinutes.compareTo(bMinutes);
    });

    return CustomScrollView(
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
                        Text('CueMe', style: theme.textTheme.labelLarge),
                        const SizedBox(height: 2),
                        Text(
                          'My Routines',
                          style: theme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push('/routine/new'),
                    tooltip: 'Add Routine',
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.s16),
              Row(
                children: [
                  ChoiceChip(
                    avatar: const Icon(Icons.calendar_month_rounded, size: 18),
                    label: const Text('Schedule'),
                    selected: filter == RoutineFilter.active,
                    onSelected: (_) => ref
                        .read(routineFilterProvider.notifier)
                        .setFilter(RoutineFilter.active),
                  ),
                  const SizedBox(width: AppTokens.s8),
                  ChoiceChip(
                    avatar: const Icon(Icons.archive_outlined, size: 18),
                    label: const Text('Archived'),
                    selected: filter == RoutineFilter.archived,
                    onSelected: (_) => ref
                        .read(routineFilterProvider.notifier)
                        .setFilter(RoutineFilter.archived),
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.s16),
              if (filter == RoutineFilter.active) ...[
                _CalendarHero(routineCount: routines.length),
                const SizedBox(height: AppTokens.s16),
                _CalendarCard(
                  month: _visibleMonth,
                  selectedDate: _selectedDate,
                  hasRoutine: (date) =>
                      routines.any((routine) => _routineRunsOn(routine, date)),
                  onPreviousMonth: () => _changeMonth(-1),
                  onNextMonth: () => _changeMonth(1),
                  onDateSelected: (date) => setState(() {
                    _selectedDate = date;
                  }),
                ),
                const SizedBox(height: AppTokens.s24),
              ],
              Row(
                children: [
                  Expanded(
                    child: Text(
                      filter == RoutineFilter.active
                          ? DateFormat('EEEE, MMMM d').format(_selectedDate)
                          : 'Archived routines',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  if (selectedRoutines.isNotEmpty)
                    Text(
                      '${selectedRoutines.length} ${selectedRoutines.length == 1 ? 'routine' : 'routines'}',
                      style: theme.textTheme.labelMedium,
                    ),
                ],
              ),
              const SizedBox(height: AppTokens.s12),
            ],
          ),
        ),
        if (selectedRoutines.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: filter == RoutineFilter.active
                  ? Icons.event_available_rounded
                  : Icons.archive_outlined,
              title: filter == RoutineFilter.active
                  ? 'A clear day'
                  : 'No archived routines',
              description: filter == RoutineFilter.active
                  ? 'Nothing is scheduled for this date. Choose another day or add a new routine.'
                  : 'Routines you archive will stay safely stored here.',
              buttonText: filter == RoutineFilter.active ? 'Add Routine' : null,
              onButtonPressed: filter == RoutineFilter.active
                  ? () => context.push('/routine/new')
                  : null,
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
              itemCount: selectedRoutines.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppTokens.s12),
              itemBuilder: (context, index) {
                final routine = selectedRoutines[index];
                return _ScheduleRoutineCard(
                  routine: routine,
                  isArchived: filter == RoutineFilter.archived,
                  onTap: () => context.push('/routine/${routine.id}/edit'),
                  onToggle: () => ref
                      .read(routinesControllerProvider.notifier)
                      .toggleActive(routine),
                  onArchive: () {
                    final controller = ref.read(
                      routinesControllerProvider.notifier,
                    );
                    if (routine.isArchived) {
                      controller.unarchiveRoutine(routine);
                    } else {
                      controller.archiveRoutine(routine);
                    }
                  },
                  onDelete: () => _confirmDelete(context, routine),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _CalendarHero extends StatelessWidget {
  const _CalendarHero({required this.routineCount});

  final int routineCount;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 148,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [AppColors.darkSurfaceWarm, AppColors.darkSurface]
              : const [Color(0xFFD89A7F), Color(0xFFC97C60)],
        ),
        borderRadius: AppTokens.borderRadiusXl,
        boxShadow: AppTokens.softShadow(color: AppColors.primary),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -22,
            top: -18,
            bottom: -18,
            width: 205,
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
                    'Plan your care',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: AppTokens.s8),
                  SizedBox(
                    width: 170,
                    child: Text(
                      routineCount == 1
                          ? '1 active routine, organized around your day.'
                          : '$routineCount active routines, organized around your day.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.84),
                        height: 1.35,
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

class _CalendarCard extends StatelessWidget {
  const _CalendarCard({
    required this.month,
    required this.selectedDate,
    required this.hasRoutine,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onDateSelected,
  });

  final DateTime month;
  final DateTime selectedDate;
  final bool Function(DateTime date) hasRoutine;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final secondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final firstDay = DateTime(month.year, month.month, 1);
    final leading = firstDay.weekday - 1;
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final cellCount = ((leading + daysInMonth + 6) ~/ 7) * 7;
    const weekdayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: AppTokens.borderRadiusLg,
        boxShadow: AppTokens.softShadow(),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onPreviousMonth,
                tooltip: 'Previous month',
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Expanded(
                child: Text(
                  DateFormat('MMMM yyyy').format(month),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              IconButton(
                onPressed: onNextMonth,
                tooltip: 'Next month',
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.s8),
          Row(
            children: weekdayLabels
                .map(
                  (label) => Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: AppTokens.s8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cellCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 42,
              mainAxisSpacing: 3,
            ),
            itemBuilder: (context, index) {
              final dayNumber = index - leading + 1;
              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const SizedBox.shrink();
              }
              final date = DateTime(month.year, month.month, dayNumber);
              final selected =
                  date.year == selectedDate.year &&
                  date.month == selectedDate.month &&
                  date.day == selectedDate.day;
              final scheduled = hasRoutine(date);
              return Semantics(
                button: true,
                selected: selected,
                label: DateFormat('MMMM d, yyyy').format(date),
                child: InkWell(
                  onTap: () => onDateSelected(date),
                  borderRadius: AppTokens.borderRadiusSm,
                  child: AnimatedContainer(
                    duration: AppTokens.durationFast,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : Colors.transparent,
                      borderRadius: AppTokens.borderRadiusSm,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$dayNumber',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: selected ? Colors.white : secondary,
                            fontWeight: selected
                                ? FontWeight.w800
                                : FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: scheduled
                                ? (selected ? Colors.white : AppColors.accent)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ScheduleRoutineCard extends StatelessWidget {
  const _ScheduleRoutineCard({
    required this.routine,
    required this.isArchived,
    required this.onTap,
    required this.onToggle,
    required this.onArchive,
    required this.onDelete,
  });

  final Routine routine;
  final bool isArchived;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final secondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final enabledTimes =
        routine.reminderTimes.where((time) => time.isEnabled).toList()
          ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final timeLabel = enabledTimes.isEmpty
        ? 'No time'
        : enabledTimes.map((time) => time.formatTime()).join('  ·  ');
    final routineColor = AppColors.getColorByKey(routine.colorKey);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTokens.borderRadiusLg,
        child: Container(
          padding: const EdgeInsets.all(AppTokens.s14),
          decoration: BoxDecoration(
            color: surface,
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
                    Text(
                      routine.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      [
                        if (routine.dosageText?.isNotEmpty == true)
                          routine.dosageText!,
                        timeLabel,
                      ].join('  ·  '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: secondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isArchived)
                IconButton(
                  onPressed: onToggle,
                  tooltip: 'Pause routine',
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTokens.borderRadiusSm,
                    ),
                  ),
                  icon: const Icon(Icons.check_rounded, size: 20),
                ),
              PopupMenuButton<String>(
                tooltip: 'Routine options',
                icon: const Icon(Icons.more_vert_rounded),
                onSelected: (value) {
                  if (value == 'edit') onTap();
                  if (value == 'archive') onArchive();
                  if (value == 'delete') onDelete();
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(
                    value: 'archive',
                    child: Text(isArchived ? 'Restore' : 'Archive'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      'Delete',
                      style: TextStyle(color: AppColors.statusMissed),
                    ),
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
