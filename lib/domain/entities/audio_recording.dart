class AudioRecording {
  final String id;
  final String localPath;
  final String? iosSoundFilename;
  final String codec;
  final int durationMs;
  final int? fileSizeBytes;
  final int revision;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AudioRecording({
    required this.id,
    required this.localPath,
    this.iosSoundFilename,
    this.codec = 'wav',
    required this.durationMs,
    this.fileSizeBytes,
    this.revision = 1,
    required this.createdAt,
    required this.updatedAt,
  });

  AudioRecording copyWith({
    String? id,
    String? localPath,
    String? iosSoundFilename,
    String? codec,
    int? durationMs,
    int? fileSizeBytes,
    int? revision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AudioRecording(
      id: id ?? this.id,
      localPath: localPath ?? this.localPath,
      iosSoundFilename: iosSoundFilename ?? this.iosSoundFilename,
      codec: codec ?? this.codec,
      durationMs: durationMs ?? this.durationMs,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      revision: revision ?? this.revision,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
