import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../core/utils/app_logger.dart';

class AudioStorageService {
  Directory? _recordingsDir;
  Directory? _iosSoundsDir;

  Future<void> initialize() async {
    final supportDir = await getApplicationSupportDirectory();
    _recordingsDir = Directory(p.join(supportDir.path, 'audio', 'recordings'));
    if (!await _recordingsDir!.exists()) {
      await _recordingsDir!.create(recursive: true);
    }

    if (Platform.isIOS) {
      final appDir = await getApplicationDocumentsDirectory();
      // On iOS, Library/Sounds is adjacent to Documents
      final libraryDir = Directory(p.join(appDir.parent.path, 'Library', 'Sounds'));
      if (!await libraryDir.exists()) {
        await libraryDir.create(recursive: true);
      }
      _iosSoundsDir = libraryDir;
    }
  }

  Future<String> getTempRecordingPath(String audioId) async {
    final tempDir = await getTemporaryDirectory();
    return p.join(tempDir.path, 'temp_rec_$audioId.wav');
  }

  Future<String> saveRecording({
    required String tempPath,
    required String audioId,
    required String routineId,
    required int revision,
  }) async {
    if (_recordingsDir == null) {
      await initialize();
    }

    final targetFile = File(p.join(_recordingsDir!.path, '$audioId.wav'));
    final source = File(tempPath);
    if (await source.exists()) {
      await source.copy(targetFile.path);
      try {
        await source.delete();
      } catch (_) {}
    } else {
      throw Exception('Source recording file does not exist at $tempPath');
    }

    // On iOS, copy to Library/Sounds
    if (Platform.isIOS && _iosSoundsDir != null) {
      final iosFilename = 'routine_${routineId}_$revision.wav';
      final iosTarget = File(p.join(_iosSoundsDir!.path, iosFilename));
      await targetFile.copy(iosTarget.path);
      AppLogger.debug('AudioStorageService', 'Copied to iOS Sounds dir: ${iosTarget.path}');
    }

    return targetFile.path;
  }

  String? getIosSoundFilename({
    required String routineId,
    required int revision,
  }) {
    if (Platform.isIOS) {
      return 'routine_${routineId}_$revision.wav';
    }
    return null;
  }

  Future<void> deleteAudio({
    required String audioId,
    String? iosSoundFilename,
  }) async {
    try {
      if (_recordingsDir != null) {
        final file = File(p.join(_recordingsDir!.path, '$audioId.wav'));
        if (await file.exists()) {
          await file.delete();
          AppLogger.debug('AudioStorageService', 'Deleted recording file: ${file.path}');
        }
      }

      if (Platform.isIOS && _iosSoundsDir != null && iosSoundFilename != null) {
        final iosFile = File(p.join(_iosSoundsDir!.path, iosSoundFilename));
        if (await iosFile.exists()) {
          await iosFile.delete();
          AppLogger.debug('AudioStorageService', 'Deleted iOS sound file: ${iosFile.path}');
        }
      }
    } catch (e) {
      AppLogger.warn('AudioStorageService', 'Error deleting audio file', e);
    }
  }
}
