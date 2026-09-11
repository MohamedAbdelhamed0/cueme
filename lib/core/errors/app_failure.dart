sealed class AppFailure implements Exception {
  final String message;
  final Object? cause;

  const AppFailure(this.message, [this.cause]);

  @override
  String toString() => '$runtimeType: $message';
}

class DatabaseFailure extends AppFailure {
  const DatabaseFailure(super.message, [super.cause]);
}

class NotificationPermissionFailure extends AppFailure {
  const NotificationPermissionFailure([
    super.message = 'Notification permission is required to deliver reminders on time.',
    super.cause,
  ]);
}

class ExactAlarmPermissionFailure extends AppFailure {
  const ExactAlarmPermissionFailure([
    super.message = 'Exact alarm permission is needed for to-the-minute reminder delivery on Android.',
    super.cause,
  ]);
}

class SchedulingFailure extends AppFailure {
  const SchedulingFailure(super.message, [super.cause]);
}

class MicrophonePermissionFailure extends AppFailure {
  const MicrophonePermissionFailure([
    super.message = 'Microphone permission is required to record custom voice reminders.',
    super.cause,
  ]);
}

class RecordingFailure extends AppFailure {
  const RecordingFailure(super.message, [super.cause]);
}

class AudioFileFailure extends AppFailure {
  const AudioFileFailure(super.message, [super.cause]);
}
