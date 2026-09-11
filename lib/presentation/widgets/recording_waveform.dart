import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';

class RecordingWaveform extends StatelessWidget {
  final double currentAmplitude; // 0.0 to 1.0
  final bool isRecording;

  const RecordingWaveform({
    super.key,
    required this.currentAmplitude,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    // Render 16 responsive animated bars
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(16, (index) {
        // Pseudo-random wave pattern modulation based on current amplitude
        final factor = (index % 4 == 0)
            ? 1.0
            : (index % 3 == 0)
                ? 0.7
                : (index % 2 == 0)
                    ? 0.5
                    : 0.3;
        final height = isRecording
            ? (10.0 + (currentAmplitude * 40.0 * factor)).clamp(8.0, 50.0)
            : 8.0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          width: 4,
          height: height,
          decoration: BoxDecoration(
            color: isRecording ? AppColors.primary : AppColors.primaryLight.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(AppTokens.radiusSm),
          ),
        );
      }),
    );
  }
}
