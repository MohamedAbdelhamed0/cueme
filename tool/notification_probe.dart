import 'dart:io';
import 'package:cueme/domain/entities/audio_recording.dart';
import 'package:cueme/domain/enums/reminder_enums.dart';
// Device regression probe. Run with CUEME_PROBE_CLEANUP=true afterward.
import 'package:cueme/app/providers/service_providers.dart';
import 'package:cueme/domain/entities/reminder_time.dart';
import 'package:cueme/domain/entities/routine.dart';
import 'package:cueme/domain/enums/routine_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  final scheduler = container.read(reminderSchedulerProvider);
  final repo = container.read(routineRepositoryProvider);
  await scheduler.initialize();
  await container.read(audioStorageServiceProvider).initialize();
  const probeId = 'cueme-device-regression-probe';
  for (final id in [probeId, '$probeId-voice', '$probeId-future']) {
    final previous = await repo.getById(id);
    await repo.deleteRoutine(id);
    final db = container.read(appDatabaseProvider);
    await (db.delete(
      db.reminderHistoryTable,
    )..where((row) => row.routineId.equals(id))).go();
    if (previous != null) {
      await scheduler.cancelRoutine(previous);
      if (previous.audioRecording != null) {
        await container
            .read(audioStorageServiceProvider)
            .deleteAudio(audioId: previous.audioRecording!.id);
      }
    }
  }
  if (const bool.fromEnvironment('CUEME_PROBE_CLEANUP')) {
    await container.read(notificationSyncServiceProvider).reconcile();
    runApp(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Probe cleaned up'))),
      ),
    );
    return;
  }
  final now = DateTime.now();
  final times = <ReminderTime>[];
  for (var i = 0; i < 3; i++) {
    final target = now.add(Duration(minutes: 2 + i * 2));
    times.add(
      ReminderTime(
        id: 'probe-time-$i',
        routineId: probeId,
        hour: target.hour,
        minute: target.minute,
        sortOrder: i,
        notificationId: 80000000 + i,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }
  final probe = Routine(
    id: probeId,
    name: 'CueMe repeat delivery test',
    category: RoutineCategory.pill,
    iconKey: 'pill',
    colorKey: 'blue',
    startDate: now,
    weekdaysMask: 127,
    createdAt: now,
    updatedAt: now,
    reminderTimes: times,
  );
  await repo.saveRoutine(probe);
  final saved = (await repo.getById(probeId))!;
  await scheduler.scheduleRoutine(saved);
  final sources = await repo.getAllActive();
  final recordings = sources.where((routine) => routine.audioRecording != null);
  if (recordings.isNotEmpty) {
    final audio = recordings.first.audioRecording!;
    final storage = container.read(audioStorageServiceProvider);
    final temp = await storage.getTempRecordingPath('cueme-probe-audio');
    await File(audio.localPath).copy(temp);
    final copiedPath = await storage.saveRecording(
      tempPath: temp,
      audioId: 'cueme-probe-audio',
      routineId: '$probeId-voice',
      revision: 1,
    );
    final voice = Routine(
      id: '$probeId-voice',
      name: 'CueMe recorded voice test',
      category: RoutineCategory.pill,
      iconKey: 'pill',
      colorKey: 'blue',
      startDate: now,
      weekdaysMask: 127,
      createdAt: now,
      updatedAt: now,
      soundMode: ReminderSoundMode.recorded,
      audioId: 'cueme-probe-audio',
      audioRecording: AudioRecording(
        id: 'cueme-probe-audio',
        localPath: copiedPath,
        durationMs: audio.durationMs,
        revision: 1,
        createdAt: now,
        updatedAt: now,
      ),
      reminderTimes: [
        times.last.copyWith(
          id: 'probe-voice-time',
          routineId: '$probeId-voice',
          notificationId: 80000003,
        ),
      ],
    );
    await repo.saveRoutine(voice);
    await scheduler.scheduleRoutine(voice);
    debugPrint('PROBE_VOICE ${times.last.formatTime()}');
  } else {
    debugPrint('PROBE_VOICE_UNAVAILABLE no saved recording');
  }
  final future = Routine(
    id: '$probeId-future',
    name: 'CueMe future start test',
    category: RoutineCategory.pill,
    iconKey: 'pill',
    colorKey: 'blue',
    startDate: now.add(const Duration(days: 30)),
    weekdaysMask: 127,
    createdAt: now,
    updatedAt: now,
    reminderTimes: [
      times.first.copyWith(
        id: 'probe-future-time',
        routineId: '$probeId-future',
        notificationId: 80000004,
      ),
    ],
  );
  await repo.saveRoutine(future);
  await scheduler.scheduleRoutine(future);
  debugPrint(
    'PROBE_SAVED ${saved.reminderTimes.map((t) => '${t.notificationId}:${t.formatTime(is24Hour: true)}').join(', ')}',
  );
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Three reminders: ${times.map((t) => t.formatTime()).join(', ')}; first while open, then close the app.',
          ),
        ),
      ),
    ),
  );
}
