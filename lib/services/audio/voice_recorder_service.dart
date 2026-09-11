abstract interface class VoiceRecorderService {
  Future<bool> hasPermission();
  Future<bool> requestPermission();
  Future<void> start(String outputPath);
  Future<String?> stop();
  Future<void> cancel();
  Stream<double> get amplitudeStream;
  bool get isRecording;
}
