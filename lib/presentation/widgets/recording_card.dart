import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers/service_providers.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';
import '../controllers/recording_controller.dart';
import 'recording_waveform.dart';

class RecordingCard extends ConsumerWidget {
  final String? existingPath;
  final int? existingDurationMs;
  final void Function(String tempPath, int durationMs) onVoiceRecorded;
  final VoidCallback onVoiceDeleted;

  const RecordingCard({
    super.key,
    this.existingPath,
    this.existingDurationMs,
    required this.onVoiceRecorded,
    required this.onVoiceDeleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final state = ref.watch(recordingControllerProvider);
    final controller = ref.read(recordingControllerProvider.notifier);
    final recorder = ref.watch(voiceRecorderServiceProvider);

    final hasAudio = state.recordedTempPath != null || existingPath != null;
    final durationSeconds = state.recordedTempPath != null
        ? state.durationSeconds
        : (existingDurationMs != null ? (existingDurationMs! / 1000).round() : 0);

    return Container(
      padding: const EdgeInsets.all(AppTokens.s20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: AppTokens.borderRadiusLg,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          if (state.errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(AppTokens.s12),
              decoration: BoxDecoration(
                color: AppColors.statusMissed.withValues(alpha: 0.1),
                borderRadius: AppTokens.borderRadiusSm,
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline_rounded, color: AppColors.statusMissed, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      state.errorMessage!,
                      style: const TextStyle(color: AppColors.statusMissed, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.s16),
          ],

          if (state.isRecording) ...[
            // Recording in progress
            StreamBuilder<double>(
              stream: recorder.amplitudeStream,
              initialData: 0.0,
              builder: (context, snapshot) {
                return RecordingWaveform(
                  currentAmplitude: snapshot.data ?? 0.0,
                  isRecording: true,
                );
              },
            ),
            const SizedBox(height: AppTokens.s16),
            Text(
              'Recording 00:${state.durationSeconds.toString().padLeft(2, '0')} / 00:${AppConstants.maxRecordingSeconds}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppTokens.s16),
            FilledButton.icon(
              onPressed: () async {
                await controller.stopRecording();
                final recState = ref.read(recordingControllerProvider);
                if (recState.recordedTempPath != null) {
                  onVoiceRecorded(
                    recState.recordedTempPath!,
                    recState.durationSeconds * 1000,
                  );
                }
              },
              icon: const Icon(Icons.stop_rounded),
              label: const Text('Stop Recording'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.statusMissed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: AppTokens.borderRadiusMd),
              ),
            ),
          ] else if (hasAudio) ...[
            // Recorded Preview State
            Row(
              children: [
                IconButton.filled(
                  icon: Icon(
                    state.isPlayingPreview ? Icons.stop_rounded : Icons.play_arrow_rounded,
                    size: 24,
                  ),
                  onPressed: () {
                    if (state.isPlayingPreview) {
                      controller.stopPreview();
                    } else {
                      final path = state.recordedTempPath ?? existingPath;
                      if (path != null) {
                        ref.read(audioPreviewServiceProvider).play(path);
                      }
                    }
                  },
                ),
                const SizedBox(width: AppTokens.s12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recorded Voice Clip',
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Duration: 00:${durationSeconds.toString().padLeft(2, '0')}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  tooltip: 'Re-record',
                  onPressed: () {
                    controller.reset();
                    controller.startRecording();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, color: AppColors.statusMissed),
                  tooltip: 'Delete recording',
                  onPressed: () {
                    controller.reset();
                    onVoiceDeleted();
                  },
                ),
              ],
            ),
          ] else ...[
            // Initial Empty Recording State
            Text(
              'Record a personal reminder message (up to ${AppConstants.maxRecordingSeconds}s)',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTokens.s16),
            FilledButton.icon(
              onPressed: () => controller.startRecording(),
              icon: const Icon(Icons.mic_rounded),
              label: const Text('Tap to Record Voice'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: AppTokens.borderRadiusMd),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
