import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../app/providers/service_providers.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/app_logger.dart';

class RecordingState {
  final bool isRecording;
  final int durationSeconds;
  final String? recordedTempPath;
  final bool isPlayingPreview;
  final String? errorMessage;

  const RecordingState({
    this.isRecording = false,
    this.durationSeconds = 0,
    this.recordedTempPath,
    this.isPlayingPreview = false,
    this.errorMessage,
  });

  RecordingState copyWith({
    bool? isRecording,
    int? durationSeconds,
    String? recordedTempPath,
    bool? isPlayingPreview,
    String? errorMessage,
    bool clearError = false,
    bool clearRecordedPath = false,
  }) {
    return RecordingState(
      isRecording: isRecording ?? this.isRecording,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      recordedTempPath: clearRecordedPath ? null : (recordedTempPath ?? this.recordedTempPath),
      isPlayingPreview: isPlayingPreview ?? this.isPlayingPreview,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class RecordingController extends Notifier<RecordingState> {
  Timer? _timer;
  StreamSubscription? _playerStateSubscription;

  @override
  RecordingState build() {
    ref.onDispose(() {
      _timer?.cancel();
      _playerStateSubscription?.cancel();
    });
    return const RecordingState();
  }

  Future<void> startRecording() async {
    state = state.copyWith(clearError: true);
    final recorder = ref.read(voiceRecorderServiceProvider);
    final storage = ref.read(audioStorageServiceProvider);

    try {
      final hasPerm = await recorder.hasPermission();
      if (!hasPerm) {
        final granted = await recorder.requestPermission();
        if (!granted) {
          state = state.copyWith(errorMessage: 'Microphone permission is required to record custom voice clips.');
          return;
        }
      }

      final tempPath = await storage.getTempRecordingPath(const Uuid().v4());
      await recorder.start(tempPath);

      state = state.copyWith(
        isRecording: true,
        durationSeconds: 0,
        clearRecordedPath: true,
      );

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final current = state.durationSeconds + 1;
        if (current >= AppConstants.maxRecordingSeconds) {
          stopRecording();
        } else {
          state = state.copyWith(durationSeconds: current);
        }
      });
    } catch (e) {
      AppLogger.warn('RecordingController', 'Failed to start recording', e);
      state = state.copyWith(isRecording: false, errorMessage: 'Could not start recording: $e');
    }
  }

  Future<void> stopRecording() async {
    _timer?.cancel();
    final recorder = ref.read(voiceRecorderServiceProvider);

    try {
      final path = await recorder.stop();
      state = state.copyWith(
        isRecording: false,
        recordedTempPath: path,
      );
    } catch (e) {
      AppLogger.warn('RecordingController', 'Failed to stop recording', e);
      state = state.copyWith(isRecording: false, errorMessage: 'Failed to stop recording');
    }
  }

  Future<void> playPreview() async {
    if (state.recordedTempPath == null) return;
    final previewService = ref.read(audioPreviewServiceProvider);

    try {
      await previewService.play(state.recordedTempPath!);
      state = state.copyWith(isPlayingPreview: true);

      _playerStateSubscription?.cancel();
      _playerStateSubscription = previewService.stateStream.listen((playerState) {
        if (playerState.toString().contains('completed') ||
            playerState.toString().contains('stopped')) {
          state = state.copyWith(isPlayingPreview: false);
        }
      });
    } catch (e) {
      AppLogger.warn('RecordingController', 'Failed to play preview', e);
      state = state.copyWith(isPlayingPreview: false);
    }
  }

  Future<void> stopPreview() async {
    final previewService = ref.read(audioPreviewServiceProvider);
    await previewService.stop();
    state = state.copyWith(isPlayingPreview: false);
  }

  void reset() {
    _timer?.cancel();
    _playerStateSubscription?.cancel();
    state = const RecordingState();
  }
}

final recordingControllerProvider =
    NotifierProvider.autoDispose<RecordingController, RecordingState>(RecordingController.new);
