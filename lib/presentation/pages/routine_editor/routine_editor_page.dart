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

  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRoutine();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Routine' : 'New Routine'),
        actions: [
          TextButton(
            onPressed: () async {
              final result = await controller.saveRoutine();
              if (result.success) {
                if (result.warning != null && context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(result.warning!)));
                }
                if (context.mounted) context.pop();
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.warning ?? 'Failed to save routine'),
                      backgroundColor: AppColors.statusMissed,
                    ),
                  );
                }
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
              controller: _nameController,
              decoration: const InputDecoration(
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
                        ? const Icon(Icons.check, size: 18, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),

            // Section B: WHEN
            _buildSectionHeader('When should CueMe remind you?'),
            // Days of week
            Text('Days of the Week', style: theme.textTheme.labelMedium),
            const SizedBox(height: AppTokens.s8),
            WeekdaySelector(
              selectedWeekdays: draft.weekdays,
              onDayToggled: controller.toggleWeekday,
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
                    controller.updateTimeAt(idx, picked);
                  }
                },
                onRemove: draft.times.length > 1
                    ? () => controller.removeTimeAt(idx)
                    : null,
              );
            }),
            const SizedBox(height: AppTokens.s4),
            OutlinedButton.icon(
              onPressed: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 12, minute: 0),
                );
                if (picked != null) {
                  controller.addTime(picked);
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
            // Start / End Date
            Row(
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
                      controller.updateEndDate(picked);
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'End Date (Optional)',
                        suffixIcon: draft.endDate != null
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () => controller.updateEndDate(null),
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
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: AppTokens.borderRadiusLg,
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
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
                          const Text('Snooze Duration'),
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
