import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// The native weekly path preserves future starts; regression-tested against the
// installed plugin's channel contract.
// ignore: implementation_imports
import 'package:flutter_local_notifications/src/platform_specifics/android/method_channel_mappers.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../core/constants/app_constants.dart';
import '../../core/utils/app_logger.dart';
import '../../domain/entities/routine.dart';
import '../../domain/repositories/routine_repository.dart';
import '../../domain/services/reminder_schedule_calculator.dart';
import '../../domain/enums/reminder_enums.dart';
import 'reminder_scheduler.dart';

class FlutterLocalNotificationScheduler implements ReminderScheduler {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  void Function(String payload)? _onNotificationTapped;
  final RoutineRepository? _routineRepository;
  Future<void> _tail = Future<void>.value();

  Future<T> _enqueue<T>(Future<T> Function() operation) {
    final result = _tail.then((_) => operation());
    // A failed operation must not prevent subsequent repairs.
    _tail = result.then<void>(
      (_) {},
      onError: (Object error, StackTrace stack) {},
    );
    return result;
  }

  FlutterLocalNotificationScheduler({
    FlutterLocalNotificationsPlugin? notificationsPlugin,
    RoutineRepository? routineRepository,
    // ignore: prefer_initializing_formals
  }) : _routineRepository = routineRepository,
       _notificationsPlugin =
           notificationsPlugin ?? FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize({
    void Function(String payload)? onNotificationTapped,
  }) async {
    _onNotificationTapped = onNotificationTapped;

    tz.initializeTimeZones();
    await _refreshTimezone();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
      linux: linuxSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          AppLogger.info(
            'NotificationScheduler',
            'Notification tapped with payload: $payload',
          );
          _onNotificationTapped?.call(payload);
        }
      },
    );
  }

  @override
  Future<bool> requestNotificationPermission() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final granted = await androidImpl?.requestNotificationsPermission();
      return granted ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      final granted = await iosImpl?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    return true;
  }

  @override
  Future<ExactAlarmCapability> getExactAlarmCapability() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final canExact =
          await androidImpl?.canScheduleExactNotifications() ?? false;
      return canExact
          ? ExactAlarmCapability.available
          : ExactAlarmCapability.needsPermission;
    }
    return ExactAlarmCapability.available;
  }

  @override
  Future<ScheduleVerification> scheduleRoutine(Routine routine) =>
      _enqueue(() async {
        final latest = _routineRepository == null
            ? routine
            : await _routineRepository.getById(routine.id);
        if (latest == null) {
          await _cancelRoutine(routine);
          return const ScheduleVerification({}, {});
        }
        return _scheduleRoutine(latest);
      });

  Future<ScheduleVerification> _scheduleRoutine(Routine routine) async {
    final expectedIds = <int>{};
    if (!routine.isActive || routine.isArchived) {
      await _cancelRoutine(routine);
      return const ScheduleVerification({}, {});
    }

    await _refreshTimezone();
    final now = tz.TZDateTime.now(tz.local);
    final dates = <int, tz.TZDateTime>{};
    for (final time in routine.reminderTimes.where((time) => time.isEnabled)) {
      for (final day in routine.selectedWeekdays) {
        final next = ReminderScheduleCalculator.nextForWeekday(
          now: now,
          startDate: routine.startDate,
          endDate: routine.endDate,
          weekday: day,
          hour: time.hour,
          minute: time.minute,
        );
        if (next != null) {
          dates[time.notificationId * 10 + day] = tz.TZDateTime.from(
            next,
            tz.local,
          );
        }
      }
    }
    expectedIds.addAll(dates.keys);
    final exactCapability = await getExactAlarmCapability();
    final scheduleMode = exactCapability == ExactAlarmCapability.available
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
    final existing = await _notificationsPlugin.pendingNotificationRequests();
    final own = existing
        .where(
          (request) => _payload(request.payload)?['routineId'] == routine.id,
        )
        .toList();
    final current = own
        .where((request) {
          final payload = _payload(request.payload);
          return payload?['scheduleRevision'] ==
                  routine.updatedAt.toIso8601String() &&
              payload?['scheduleTimezone'] == tz.local.name &&
              payload?['scheduleMode'] == scheduleMode.name;
        })
        .map((request) => request.id)
        .toSet();
    // Never cancel a valid alarm on resume. Android may still be delivering a
    // due alarm; replacing it with next week's occurrence loses that reminder.
    if (current.containsAll(expectedIds) &&
        own.every((request) => expectedIds.contains(request.id))) {
      return ScheduleVerification(expectedIds, current);
    }
    final notificationDetails = await _buildNotificationDetails(routine);
    for (final request in own) {
      await _cancelByNotificationId(request.id);
    }
    await _cancelRoutine(routine);

    for (final reminderTime in routine.reminderTimes) {
      if (!reminderTime.isEnabled) continue;

      for (int weekday = 1; weekday <= 7; weekday++) {
        if (!routine.isScheduledForWeekday(weekday)) continue;

        // Unique notification ID per weekday & reminder time:
        // Base notificationId multiplied by 10 plus weekday
        final id = (reminderTime.notificationId * 10) + weekday;

        final nextDate = dates[id];
        if (nextDate == null) continue;

        final title = routine.name;
        final bodyParts = <String>[];
        if (routine.dosageText != null && routine.dosageText!.isNotEmpty) {
          bodyParts.add(routine.dosageText!);
        }
        if (routine.instructions != null && routine.instructions!.isNotEmpty) {
          bodyParts.add(routine.instructions!);
        }
        final body = bodyParts.isNotEmpty
            ? bodyParts.join(' • ')
            : 'Time for your ${routine.category.displayName.toLowerCase()}';

        final payload = jsonEncode({
          'v': AppConstants.notificationPayloadVersion,
          'type': 'routineReminder',
          'routineId': routine.id,
          'reminderTimeId': reminderTime.id,
          'scheduledFor': nextDate.toIso8601String(),
          'scheduleRevision': routine.updatedAt.toIso8601String(),
          'scheduleTimezone': tz.local.name,
          'scheduleMode': scheduleMode.name,
        });

        try {
          // Android's matching-components API discards a future start date.
          // Its native weekly-repeat path retains the explicit first date.
          if (defaultTargetPlatform == TargetPlatform.android &&
              ReminderScheduleCalculator.dateOnly(routine.startDate).isAfter(
                ReminderScheduleCalculator.dateOnly(
                  tz.TZDateTime.now(tz.local),
                ),
              )) {
            await const MethodChannel(
              'dexterous.com/flutter/local_notifications',
            ).invokeMethod<void>('zonedSchedule', {
              'id': id, 'title': title, 'body': body, 'payload': payload,
              'timeZoneName': tz.local.name,
              'scheduledDateTime':
                  '${nextDate.year.toString().padLeft(4, '0')}-${nextDate.month.toString().padLeft(2, '0')}-${nextDate.day.toString().padLeft(2, '0')}T${nextDate.hour.toString().padLeft(2, '0')}:${nextDate.minute.toString().padLeft(2, '0')}:00',
              'scheduledNotificationRepeatFrequency': 1, // native Weekly
              'platformSpecifics': {
                ...notificationDetails.android!.toMap(),
                'scheduleMode': scheduleMode.name,
              },
            });
          } else {
            await _notificationsPlugin.zonedSchedule(
              id: id,
              title: title,
              body: body,
              scheduledDate: nextDate,
              notificationDetails: notificationDetails,
              androidScheduleMode: scheduleMode,
              matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
              payload: payload,
            );
          }
          AppLogger.debug(
            'NotificationScheduler',
            'Scheduled notification id=$id at $nextDate',
          );
        } catch (e) {
          AppLogger.warn(
            'NotificationScheduler',
            'Failed to schedule notification id=$id',
            e,
          );
          rethrow;
        }
      }
    }
    final pending = await _notificationsPlugin.pendingNotificationRequests();
    final verification = ScheduleVerification(
      expectedIds,
      pending.map((request) => request.id).toSet(),
    );
    if (!verification.isComplete) {
      throw StateError('Missing reminder alarms: ${verification.missingIds}');
    }
    return verification;
  }

  @override
  Future<void> cancelRoutine(Routine routine) =>
      _enqueue(() => _cancelRoutine(routine));

  Future<void> _cancelRoutine(Routine routine) async {
    for (final reminderTime in routine.reminderTimes) {
      for (int weekday = 1; weekday <= 7; weekday++) {
        final id = (reminderTime.notificationId * 10) + weekday;
        await _cancelByNotificationId(id);
      }
    }
  }

  @override
  Future<void> cancelByNotificationId(int notificationId) =>
      _enqueue(() => _cancelByNotificationId(notificationId));

  Future<void> _cancelByNotificationId(int notificationId) async {
    try {
      await _notificationsPlugin.cancel(id: notificationId);
      AppLogger.debug(
        'NotificationScheduler',
        'Cancelled notificationId=$notificationId',
      );
    } catch (e) {
      AppLogger.warn(
        'NotificationScheduler',
        'Error cancelling notification $notificationId',
        e,
      );
      rethrow;
    }
  }

  @override
  Future<void> rescheduleAll(
    List<Routine> activeRoutines,
  ) => _enqueue(() async {
    // Reload inside the queue, after pending saves/cancellations have finished.
    final latest = _routineRepository == null
        ? activeRoutines
        : await _routineRepository.getAllActive();
    final activeIds = latest.map((routine) => routine.id).toSet();
    for (final request
        in await _notificationsPlugin.pendingNotificationRequests()) {
      final payload = _payload(request.payload);
      if (payload?['type'] == 'routineReminder' &&
          !activeIds.contains(payload?['routineId'])) {
        await _cancelByNotificationId(request.id);
      }
    }
    Object? firstError;
    for (final routine in latest) {
      try {
        await _scheduleRoutine(routine);
      } catch (error, stack) {
        firstError ??= error;
        AppLogger.error(
          'NotificationScheduler',
          'Failed rebuilding routine ${routine.id}',
          error,
          stack,
        );
      }
    }
    if (firstError != null) throw firstError;
  });

  Map<String, dynamic>? _payload(String? value) {
    try {
      return value == null ? null : jsonDecode(value) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> testNotification() => _enqueue(_testNotification);

  Future<void> _testNotification() async {
    await _refreshTimezone();
    final exactCapability = await getExactAlarmCapability();
    const androidDetails = AndroidNotificationDetails(
      'cueme_test_channel',
      'Test Reminders',
      channelDescription: 'Channel for verifying CueMe notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.zonedSchedule(
      id: 999999,
      title: 'Test Reminder from CueMe',
      body: 'This reminder was scheduled while CueMe was open.',
      scheduledDate: tz.TZDateTime.now(
        tz.local,
      ).add(const Duration(seconds: 30)),
      androidScheduleMode: exactCapability == ExactAlarmCapability.available
          ? AndroidScheduleMode.exactAllowWhileIdle
          : AndroidScheduleMode.inexactAllowWhileIdle,
      notificationDetails: details,
      payload: jsonEncode({'v': 1, 'type': 'test'}),
    );
  }

  Future<void> _refreshTimezone() async {
    final deviceTimezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(deviceTimezone.identifier));
  }

  Future<NotificationDetails> _buildNotificationDetails(Routine routine) async {
    String? androidSoundUri;
    if (defaultTargetPlatform == TargetPlatform.android &&
        routine.soundMode == ReminderSoundMode.recorded &&
        routine.audioRecording != null) {
      androidSoundUri = await const MethodChannel('cueme/notification_sounds')
          .invokeMethod<String>('getSoundUri', {
            'path': routine.audioRecording!.localPath,
          });
    }
    // 1. Android channel versioning
    final revision = routine.audioRecording?.revision ?? 1;
    final channelId =
        routine.soundMode == ReminderSoundMode.recorded &&
            routine.audioRecording != null
        ? 'routine_${routine.id}_sound_${revision}_v2'
        : (routine.soundMode == ReminderSoundMode.silent
              ? 'cueme_silent'
              : 'cueme_default');

    final channelName = routine.soundMode == ReminderSoundMode.recorded
        ? 'Routine ${routine.name} (Custom Voice)'
        : (routine.soundMode == ReminderSoundMode.silent
              ? 'Silent Reminders'
              : 'Routine Reminders');

    final soundMode = routine.soundMode;

    AndroidNotificationDetails androidDetails;
    if (soundMode == ReminderSoundMode.silent) {
      androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.low,
        priority: Priority.low,
        playSound: false,
        enableVibration: routine.vibrationEnabled,
      );
    } else if (soundMode == ReminderSoundMode.recorded &&
        routine.audioRecording != null) {
      // Uri sound or versioned channel
      androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: 'Reminders with personalized recorded voice',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: routine.vibrationEnabled,
        // Fallback to system if audio file unavailable on device
        sound: androidSoundUri != null
            ? UriAndroidNotificationSound(androidSoundUri)
            : null,
        actions: const [
          AndroidNotificationAction('action_done', 'Done'),
          AndroidNotificationAction('action_snooze', 'Snooze'),
        ],
      );
    } else {
      // System default sound
      androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: 'Standard routine reminders with system sound',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: routine.vibrationEnabled,
        actions: const [
          AndroidNotificationAction('action_done', 'Done'),
          AndroidNotificationAction('action_snooze', 'Snooze'),
        ],
      );
    }

    DarwinNotificationDetails iosDetails;
    if (soundMode == ReminderSoundMode.silent) {
      iosDetails = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: false,
      );
    } else if (soundMode == ReminderSoundMode.recorded &&
        routine.audioRecording?.iosSoundFilename != null) {
      iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: routine.audioRecording!.iosSoundFilename,
      );
    } else {
      iosDetails = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
    }

    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }
}
