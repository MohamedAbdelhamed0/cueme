import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/service_providers.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../controllers/today_controller.dart';

class ReminderRingPage extends ConsumerStatefulWidget {
  final String? routineId;

  const ReminderRingPage({super.key, this.routineId});

  @override
  ConsumerState<ReminderRingPage> createState() => _ReminderRingPageState();
}

class _ReminderRingPageState extends ConsumerState<ReminderRingPage> {
  bool _isPlayingVoice = false;

  @override
  void initState() {
    super.initState();
    _playVoiceIfAvailable();
  }

  void _playVoiceIfAvailable() async {
    // Check if voice clip exists for this routine
    if (widget.routineId != null) {
      final routine = await ref.read(routineRepositoryProvider).getById(widget.routineId!);
      if (routine?.audioRecording != null) {
        final previewService = ref.read(audioPreviewServiceProvider);
        await previewService.play(routine!.audioRecording!.localPath);
        if (mounted) setState(() => _isPlayingVoice = true);

        previewService.stateStream.listen((state) {
          if (state.toString().contains('completed') || state.toString().contains('stopped')) {
            if (mounted) setState(() => _isPlayingVoice = false);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    ref.read(audioPreviewServiceProvider).stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final occurrencesAsync = ref.watch(todayOccurrencesProvider);
    final controller = ref.read(todayControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: occurrencesAsync.when(
          data: (occurrences) {
            final target = widget.routineId != null
                ? occurrences.where((o) => o.routine.id == widget.routineId).firstOrNull
                : occurrences.firstOrNull;

            if (target == null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, size: 64, color: AppColors.statusDone),
                    const SizedBox(height: 16),
                    const Text('No pending reminder due right now!'),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => context.go('/today'),
                      child: const Text('Back to Today'),
                    ),
                  ],
                ),
              );
            }

            final routine = target.routine;
            final routineColor = AppColors.getColorByKey(routine.colorKey);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.s32, vertical: AppTokens.s24),
              child: Column(
                children: [
                  const Spacer(),
                  // Large Category Icon
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: routineColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: routineColor, width: 2),
                    ),
                    child: Icon(
                      routine.category.icon,
                      size: 48,
                      color: routineColor,
                    ),
                  ),
                  const SizedBox(height: AppTokens.s24),

                  // Routine Name
                  Text(
                    routine.name,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTokens.s8),

                  // Dosage / Instructions
                  if (routine.dosageText != null || routine.instructions != null) ...[
                    Text(
                      [
                        if (routine.dosageText != null) routine.dosageText,
                        if (routine.instructions != null) routine.instructions,
                      ].join(' • '),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTokens.s8),
                  ],

                  // Scheduled Time
                  Text(
                    'Scheduled for ${target.scheduledDateTime.toFormattedTime()}',
                    style: TextStyle(
                      color: routineColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  if (_isPlayingVoice) ...[
                    const SizedBox(height: AppTokens.s16),
                    OutlinedButton.icon(
                      onPressed: () {
                        ref.read(audioPreviewServiceProvider).stop();
                        setState(() => _isPlayingVoice = false);
                      },
                      icon: const Icon(Icons.volume_off_rounded),
                      label: const Text('Stop Voice Sound'),
                    ),
                  ],

                  const Spacer(flex: 2),

                  // Actions: Done, Snooze, Skip
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () async {
                        await controller.markDone(target);
                        if (context.mounted) context.go('/today');
                      },
                      icon: const Icon(Icons.check_rounded, size: 24),
                      label: Text(
                        'Mark as ${routine.verb}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.statusDone,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: AppTokens.borderRadiusLg),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTokens.s12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await controller.snooze(target);
                        if (context.mounted) context.go('/today');
                      },
                      icon: const Icon(Icons.snooze_rounded),
                      label: Text('Snooze ${routine.snoozeMinutes} min'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: AppTokens.borderRadiusLg),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTokens.s8),

                  TextButton(
                    onPressed: () async {
                      await controller.skip(target);
                      if (context.mounted) context.go('/today');
                    },
                    child: const Text('Skip this time'),
                  ),

                  const SizedBox(height: AppTokens.s16),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
