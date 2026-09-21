// Manual device probe. Uses an existing recording without changing routine data.
// After testing, install/run lib/main.dart to remove the temporary alarm.
import 'package:cueme/app/providers/service_providers.dart';
import 'package:cueme/domain/entities/reminder_time.dart';
import 'package:cueme/domain/entities/routine.dart';
import 'package:cueme/domain/enums/reminder_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  final scheduler = container.read(reminderSchedulerProvider);
  await scheduler.initialize();
  final routines = await container
      .read(routineRepositoryProvider)
      .getAllActive();
  final source = routines.firstWhere((r) => r.audioRecording != null);
  final target = DateTime.now().add(const Duration(minutes: 2));
  final probe = source.copyWith(
    name: 'CueMe background voice test',
    soundMode: ReminderSoundMode.recorded,
    weekdaysMask: Routine.maskFromWeekdays({target.weekday}),
    endDate: target.add(const Duration(days: 1)),
    reminderTimes: [
      ReminderTime(
        id: 'background-probe',
        routineId: source.id,
        hour: target.hour,
        minute: target.minute,
        notificationId: 80000000,
        createdAt: target,
        updatedAt: target,
      ),
    ],
  );
  await scheduler.scheduleRoutine(probe);
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Voice test scheduled for ${target.hour}:${target.minute.toString().padLeft(2, '0')}.\nClose the app now.',
          ),
        ),
      ),
    ),
  );
}
