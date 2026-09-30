import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/service_providers.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../domain/entities/routine.dart';
import '../../../domain/enums/reminder_enums.dart';
import '../../../domain/enums/routine_category.dart';
import '../../../domain/services/reminder_schedule_calculator.dart';
import '../../controllers/routine_editor_controller.dart';
import '../../widgets/recording_card.dart';
import '../../widgets/reminder_time_tile.dart';
import '../../widgets/weekday_selector.dart';

class RoutineEditorPage extends ConsumerStatefulWidget {
  final String? routineId;

  const RoutineEditorPage({super.key, this.routineId});

  @override
  ConsumerState<RoutineEditorPage> createState() => _RoutineEditorPageState();
}

class _RoutineEditorPageState extends ConsumerState<RoutineEditorPage> {
  Routine? _initialRoutine;
  bool _isLoadingRoutine = true;
  bool _isSaving = false;
  bool _submitted = false;
  bool _customDays = false;
  String? _timeError;
  String? _scheduleWarning;
  Routine? _savedRoutine;
  Timer? _previewTimer;
  final _nameKey = GlobalKey();
  final _scheduleKey = GlobalKey();
  final _datesKey = GlobalKey();

  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRoutine();
    _previewTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  void _loadRoutine() async {
    if (widget.routineId != null) {
      final repo = ref.read(routineRepositoryProvider);
      final r = await repo.getById(widget.routineId!);
      if (r != null) {
        _initialRoutine = r;
        _nameController.text = r.name;
        _dosageController.text = r.dosageText ?? '';
        _instructionsController.text = r.instructions ?? '';
      }
    }
    if (mounted) {
      setState(() => _isLoadingRoutine = false);
    }
  }

  @override
  void dispose() {
    _previewTimer?.cancel();
    _nameController.dispose();
    _dosageController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTokens.s24, bottom: AppTokens.s12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
    );
  }

  Future<void> _save(
    RoutineEditorController controller,
    RoutineDraft draft,
  ) async {
    if (_isSaving) return;
    setState(() => _submitted = true);
    final error = draft.validate();
    if (error != null) {
      final key = error.startsWith('Routine name')
          ? _nameKey
          : error.startsWith('End date')
          ? _datesKey
          : _scheduleKey;
      await WidgetsBinding.instance.endOfFrame;
      if (key.currentContext != null) {
        await Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(milliseconds: 250),
          alignment: 0.15,
        );
      }
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _isSaving = true);
    try {
      final result = await controller.saveRoutine();
      if (!mounted) return;
      if (result.success && result.warning == null) {
        context.pop();
      } else if (result.success) {
        setState(() {
          _savedRoutine = result.routine;
          _scheduleWarning = result.warning;
        });
        await WidgetsBinding.instance.endOfFrame;
        if (mounted && _datesKey.currentContext != null) {
          await Scrollable.ensureVisible(
            _datesKey.currentContext!,
            duration: const Duration(milliseconds: 250),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.warning ?? 'Failed to save routine')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _retryReminders() async {
    final routine = _savedRoutine;
    if (routine == null || _isSaving) return;
    setState(() => _isSaving = true);
    try {
      final scheduler = ref.read(reminderSchedulerProvider);
      final allowed = await scheduler.requestNotificationPermission();
      final result = await scheduler.scheduleRoutine(routine);
      final exact = await scheduler.getExactAlarmCapability();
      if (!mounted) return;
      setState(
        () => _scheduleWarning =
            allowed &&
                result.isComplete &&
                exact == ExactAlarmCapability.available
            ? null
            : 'Routine saved, reminders need attention',
      );
      if (_scheduleWarning == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reminders scheduled successfully')),
        );
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _scheduleWarning = 'Routine saved, reminders need attention',
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Widget _scheduleSummary(RoutineDraft draft) {
    final now = DateTime.now();
    final next = ReminderScheduleCalculator.next(
      now: now,
      startDate: draft.startDate,
      endDate: draft.endDate,
      weekdays: draft.weekdays,
      times: draft.times.map((time) => (hour: time.hour, minute: time.minute)),
    );
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final days = (draft.weekdays.toList()..sort())
        .map((day) => dayNames[day - 1])
        .join(', ');
    final hasPassed = draft.times.any(
      (time) => time.hour * 60 + time.minute <= now.hour * 60 + now.minute,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTokens.s16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppTokens.s16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: AppTokens.borderRadiusLg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your reminder schedule',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              '${draft.weekdays.length == 7 ? 'Every day' : days} at ${draft.times.map((time) => time.format(context)).join(', ')}',
            ),
            Text(
              next == null
                  ? 'No upcoming reminders within these dates'
                  : 'Next: ${next.toFormattedDate()} at ${TimeOfDay.fromDateTime(next).format(context)}',
            ),
            if (hasPassed)
              const Text(
                'Times already passed today will notify on the next selected day.',
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingRoutine) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final draft = ref.watch(routineEditorControllerProvider(_initialRoutine));
    final controller = ref.read(
      routineEditorControllerProvider(_initialRoutine).notifier,
    );

    final isEdit = widget.routineId != null;
    final selectedColor = AppColors.getColorByKey(draft.colorKey);
    final validation = _submitted ? draft.validate() : null;
    final nameError =
        validation != null && validation.startsWith('Routine name')
        ? validation
        : null;
    final dateError = validation != null && validation.startsWith('End date')
        ? validation
        : null;
    final daysPreset = !_customDays && draft.weekdays.length == 7
        ? 'Every day'
        : !_customDays &&
              draft.weekdays.length == 5 &&
              draft.weekdays.containsAll({1, 2, 3, 4, 5})
        ? 'Weekdays'
        : 'Custom';

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Routine' : 'New Routine'),
        actions: [
          TextButton(
            onPressed: _isSaving
                ? null
                : () => _save(
                    controller,
                    ref.read(routineEditorControllerProvider(_initialRoutine)),
                  ),
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Save',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
          ),
        ],
      ),
      body: AbsorbPointer(
        absorbing: _isSaving,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppTokens.s20,
            0,
            AppTokens.s20,
            AppTokens.s48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CategoryHero(
                category: draft.category,
                color: selectedColor,
                isEdit: isEdit,
              ),

              // Section A: WHAT
              _buildSectionHeader('What are you planning?'),
              TextField(
                key: _nameKey,
                controller: _nameController,
                decoration: InputDecoration(
                  errorText: nameError,
                  labelText: 'Routine Name*',
                  hintText: 'e.g. Vitamin D, Face Cream, Eye Drops',
                ),
                onChanged: controller.updateName,
              ),
              const SizedBox(height: AppTokens.s16),

              // Category picker
              Text('Category', style: theme.textTheme.labelMedium),
              const SizedBox(height: AppTokens.s8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: RoutineCategory.values.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppTokens.s12,
                  mainAxisSpacing: AppTokens.s12,
                  childAspectRatio: 1.34,
                ),
                itemBuilder: (context, index) {
                  final cat = RoutineCategory.values[index];
                  final isSelected = draft.category == cat;
                  return _CategoryCard(
                    category: cat,
                    selected: isSelected,
                    onTap: () => controller.updateCategory(cat),
                  );
                },
              ),

              const SizedBox(height: AppTokens.s16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _dosageController,
                      decoration: const InputDecoration(
                        labelText: 'Dosage / Amount',
                        hintText: 'e.g. 1 tablet, 2 drops',
                      ),
                      onChanged: controller.updateDosage,
                    ),
                  ),
                  const SizedBox(width: AppTokens.s12),
                  Expanded(
                    child: TextField(
                      controller: _instructionsController,
                      decoration: const InputDecoration(
                        labelText: 'Instructions',
                        hintText: 'e.g. After breakfast',
                      ),
                      onChanged: controller.updateInstructions,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTokens.s16),
              // Color palette picker
              Text('Accent Color', style: theme.textTheme.labelMedium),
              const SizedBox(height: AppTokens.s8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: AppColors.routinePalette.entries.map((entry) {
                  final isSelected = draft.colorKey == entry.key;
                  return GestureDetector(
                    onTap: () => controller.updateColorKey(entry.key),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: entry.value,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: entry.value.withValues(alpha: 0.5),
                                  blurRadius: 8,
                                ),
                              ]
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),

              // Section B: WHEN
              _buildSectionHeader('When should CueMe remind you?'),
              // Days of week
              Text(
                'Days of the Week',
                key: _scheduleKey,
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: AppTokens.s8),
              Wrap(
                spacing: 8,
                children: ['Every day', 'Weekdays', 'Custom']
                    .map(
                      (label) => ChoiceChip(
                        label: Text(label),
                        selected: daysPreset == label,
                        onSelected: (_) {
                          setState(() => _customDays = label == 'Custom');
                          if (label == 'Every day') {
                            controller.setWeekdays({1, 2, 3, 4, 5, 6, 7});
                          }
                          if (label == 'Weekdays') {
                            controller.setWeekdays({1, 2, 3, 4, 5});
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: AppTokens.s8),
              WeekdaySelector(
                selectedWeekdays: draft.weekdays,
                onDayToggled: (day) {
                  setState(() => _customDays = true);
                  controller.toggleWeekday(day);
                },
              ),
              const SizedBox(height: AppTokens.s16),

              // Daily Times
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Reminder Times',
                    style: theme.textTheme.labelMedium,
                  ),
                  Text(
                    draft.times.length == 1
                        ? '1 time/day'
                        : '${draft.times.length} times/day',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.s8),
              ...draft.times.asMap().entries.map((entry) {
                final idx = entry.key;
                final time = entry.value;
                return ReminderTimeTile(
                  time: time,
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: time,
                    );
                    if (picked != null) {
                      if (!mounted) return;
                      final error = controller.updateTimeAt(idx, picked);
                      setState(() => _timeError = error);
                    }
                  },
                  onRemove: draft.times.length > 1
                      ? () => controller.removeTimeAt(idx)
                      : null,
                );
              }),
              if (_timeError != null)
                Text(
                  _timeError!,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              if (validation != null &&
                  (validation.contains('at least one') ||
                      validation.contains('Duplicate reminder')))
                Text(
                  validation,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              const SizedBox(height: AppTokens.s4),
              OutlinedButton.icon(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 12, minute: 0),
                  );
                  if (picked != null) {
                    if (!mounted) return;
                    final error = controller.addTime(picked);
                    setState(() => _timeError = error);
                  }
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Another Time'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTokens.borderRadiusMd,
                  ),
                ),
              ),

              const SizedBox(height: AppTokens.s16),
              _scheduleSummary(draft),
              // Start / End Date
              Row(
                key: _datesKey,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: draft.startDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2035),
                        );
                        if (picked != null) controller.updateStartDate(picked);
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Start Date',
                        ),
                        child: Text(draft.startDate.toFormattedDate()),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTokens.s12),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate:
                              draft.endDate ??
                              draft.startDate.add(const Duration(days: 30)),
                          firstDate: draft.startDate,
                          lastDate: DateTime(2035),
                        );
                        if (picked != null) controller.updateEndDate(picked);
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'End Date (Optional)',
                          suffixIcon: draft.endDate != null
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () =>
                                      controller.updateEndDate(null),
                                )
                              : null,
                        ),
                        child: Text(
                          draft.endDate != null
                              ? draft.endDate!.toFormattedDate()
                              : 'Ongoing',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              if (dateError != null)
                Text(
                  dateError,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              if (_scheduleWarning != null) ...[
                const SizedBox(height: AppTokens.s16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTokens.s16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _scheduleWarning!,
                          style: theme.textTheme.titleSmall,
                        ),
                        const Text(
                          'Your routine is saved. Check notification access and retry its reminders.',
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            TextButton(
                              onPressed: _retryReminders,
                              child: const Text('Retry reminders'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final permissions = ref.read(
                                  permissionServiceProvider,
                                );
                                final scheduler = ref.read(
                                  reminderSchedulerProvider,
                                );
                                if (await scheduler.getExactAlarmCapability() !=
                                    ExactAlarmCapability.available) {
                                  await permissions.requestExactAlarm();
                                } else {
                                  await permissions.openAppSettingsPage();
                                }
                              },
                              child: const Text('Settings'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Section C: SOUND
              _buildSectionHeader('Reminder sound'),
              SegmentedButton<ReminderSoundMode>(
                segments: const [
                  ButtonSegment(
                    value: ReminderSoundMode.recorded,
                    label: Text('Voice Clip'),
                    icon: Icon(Icons.mic_rounded),
                  ),
                  ButtonSegment(
                    value: ReminderSoundMode.system,
                    label: Text('System Sound'),
                    icon: Icon(Icons.notifications_active_rounded),
                  ),
                  ButtonSegment(
                    value: ReminderSoundMode.silent,
                    label: Text('Silent'),
                    icon: Icon(Icons.volume_off_rounded),
                  ),
                ],
                selected: {draft.soundMode},
                onSelectionChanged: (set) => controller.setSoundMode(set.first),
              ),
              const SizedBox(height: AppTokens.s16),
              if (draft.soundMode == ReminderSoundMode.recorded)
                RecordingCard(
                  existingPath: draft.existingAudioPath,
                  existingDurationMs: draft.audioDurationMs,
                  onVoiceRecorded: (tempPath, durationMs) {
                    controller.attachRecordedVoice(
                      tempPath: tempPath,
                      durationMs: durationMs,
                    );
                  },
                  onVoiceDeleted: controller.removeRecordedVoice,
                ),

              // Section D: BEHAVIOR
              _buildSectionHeader('Reminder behavior'),
              Material(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: AppTokens.borderRadiusLg,
                  side: BorderSide(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SwitchListTile.adaptive(
                      title: const Text('Vibration'),
                      subtitle: const Text('Vibrate phone when reminder fires'),
                      value: draft.vibrationEnabled,
                      activeTrackColor: AppColors.primary,
                      onChanged: controller.updateVibration,
                    ),
                    const Divider(height: 1),
                    SwitchListTile.adaptive(
                      title: const Text('Allow Snooze'),
                      subtitle: const Text('Show snooze button on reminders'),
                      value: draft.snoozeEnabled,
                      activeTrackColor: AppColors.primary,
                      onChanged: controller.updateSnoozeEnabled,
                    ),
                    if (draft.snoozeEnabled) ...[
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text('Snooze Duration')),
                            DropdownButton<int>(
                              value: draft.snoozeMinutes,
                              underline: const SizedBox(),
                              items: const [
                                DropdownMenuItem(
                                  value: 5,
                                  child: Text('5 minutes'),
                                ),
                                DropdownMenuItem(
                                  value: 10,
                                  child: Text('10 minutes'),
                                ),
                                DropdownMenuItem(
                                  value: 15,
                                  child: Text('15 minutes'),
                                ),
                                DropdownMenuItem(
                                  value: 30,
                                  child: Text('30 minutes'),
                                ),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  controller.updateSnoozeMinutes(val);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryHero extends StatelessWidget {
  const _CategoryHero({
    required this.category,
    required this.color,
    required this.isEdit,
  });

  final RoutineCategory category;
  final Color color;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedContainer(
      duration: AppTokens.durationMedium,
      height: 164,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: isDark ? 0.52 : 0.72),
            isDark ? AppColors.darkSurface : AppColors.lightSurfaceWarm,
          ],
        ),
        borderRadius: AppTokens.borderRadiusXl,
        boxShadow: AppTokens.softShadow(color: color),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -16,
            bottom: -16,
            width: 170,
            child: AnimatedSwitcher(
              duration: AppTokens.durationMedium,
              child: Image.asset(
                category.assetPath,
                key: ValueKey(category),
                fit: BoxFit.contain,
              ),
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
                    isEdit ? 'Update your routine' : 'Create your routine',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: AppTokens.s8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: AppTokens.borderRadiusPill,
                    ),
                    child: Text(
                      category.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
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

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final RoutineCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = AppColors.getColorByKey(category.suggestedColor);
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Semantics(
      button: true,
      selected: selected,
      label: category.displayName,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppTokens.borderRadiusLg,
          child: AnimatedContainer(
            duration: AppTokens.durationFast,
            padding: const EdgeInsets.all(AppTokens.s12),
            decoration: BoxDecoration(
              color: selected ? color.withValues(alpha: 0.16) : surface,
              borderRadius: AppTokens.borderRadiusLg,
              border: Border.all(
                color: selected
                    ? color
                    : theme.colorScheme.outline.withValues(alpha: 0.45),
                width: selected ? 2 : 1,
              ),
              boxShadow: selected ? AppTokens.softShadow(color: color) : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Image.asset(category.assetPath, fit: BoxFit.contain),
                ),
                const SizedBox(width: AppTokens.s8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          category.displayName,
                          maxLines: 1,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Icon(
                        selected ? Icons.check_circle_rounded : category.icon,
                        color: selected ? color : theme.colorScheme.outline,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
