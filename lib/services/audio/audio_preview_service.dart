import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import '../../core/utils/app_logger.dart';

class AudioPreviewService {
  final AudioPlayer _player;

  AudioPreviewService({AudioPlayer? player}) : _player = player ?? AudioPlayer();

  Stream<PlayerState> get stateStream => _player.onPlayerStateChanged;
  Stream<Duration> get positionStream => _player.onPositionChanged;
  Stream<Duration> get durationStream => _player.onDurationChanged;

  Future<void> play(String localFilePath) async {
    try {
      await _player.stop();
      await _player.play(DeviceFileSource(localFilePath));
      AppLogger.debug('AudioPreview', 'Playing file: $localFilePath');
    } catch (e) {
      AppLogger.warn('AudioPreview', 'Failed to play preview', e);
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  void dispose() {
    _player.dispose();
  }
}
