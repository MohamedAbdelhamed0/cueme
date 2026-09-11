import 'dart:async';
import 'package:record/record.dart';
import '../../core/utils/app_logger.dart';
import 'voice_recorder_service.dart';

class VoiceRecorderServiceImpl implements VoiceRecorderService {
  final AudioRecorder _recorder;
  final _amplitudeController = StreamController<double>.broadcast();
  Timer? _amplitudeTimer;
  bool _isRecording = false;

  VoiceRecorderServiceImpl({AudioRecorder? recorder})
      : _recorder = recorder ?? AudioRecorder();

  @override
  Stream<double> get amplitudeStream => _amplitudeController.stream;

  @override
  bool get isRecording => _isRecording;

  @override
  Future<bool> hasPermission() async {
    return _recorder.hasPermission();
  }

  @override
  Future<bool> requestPermission() async {
    return _recorder.hasPermission();
  }

  @override
  Future<void> start(String outputPath) async {
    final hasPerm = await hasPermission();
    if (!hasPerm) {
      throw Exception('Microphone permission not granted');
    }

    // Configure 16-bit Linear PCM WAV for maximum OS notification sound compatibility
    const config = RecordConfig(
      encoder: AudioEncoder.wav,
      sampleRate: 44100,
      bitRate: 128000,
      numChannels: 1,
    );

    await _recorder.start(config, path: outputPath);
    _isRecording = true;
    AppLogger.debug('VoiceRecorder', 'Recording started at $outputPath');

    _amplitudeTimer?.cancel();
    _amplitudeTimer = Timer.periodic(const Duration(milliseconds: 100), (_) async {
      if (!_isRecording) return;
      try {
        final amp = await _recorder.getAmplitude();
        // Convert dB (-160 to 0) to normalized 0.0 - 1.0 range
        final currentDb = amp.current.clamp(-60.0, 0.0);
        final normalized = (currentDb + 60.0) / 60.0;
        _amplitudeController.add(normalized);
      } catch (_) {}
    });
  }

  @override
  Future<String?> stop() async {
    _amplitudeTimer?.cancel();
    _isRecording = false;
    final path = await _recorder.stop();
    AppLogger.debug('VoiceRecorder', 'Recording stopped, path: $path');
    return path;
  }

  @override
  Future<void> cancel() async {
    _amplitudeTimer?.cancel();
    _isRecording = false;
    await _recorder.cancel();
    AppLogger.debug('VoiceRecorder', 'Recording cancelled');
  }

  void dispose() {
    _amplitudeTimer?.cancel();
    _amplitudeController.close();
    _recorder.dispose();
  }
}
