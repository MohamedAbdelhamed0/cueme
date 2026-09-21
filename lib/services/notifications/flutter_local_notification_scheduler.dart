import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../core/constants/app_constants.dart';
import '../../core/utils/app_logger.dart';
import '../../domain/entities/routine.dart';
import '../../domain/enums/reminder_enums.dart';
import 'reminder_scheduler.dart';

class FlutterLocalNotificationScheduler implements ReminderScheduler {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  void Function(String payload)? _onNotificationTapped;

  FlutterLocalNotificationScheduler({
    FlutterLocalNotificationsPlugin? notificationsPlugin,
  }) : _notificationsPlugin =
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
    if (Platform.isAndroid) {
      final androidImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final granted = await androidImpl?.requestNotificationsPermission();
      return granted ?? false;
    } else if (Platform.isIOS) {
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
    if (Platform.isAndroid) {
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
  Future<void> scheduleRoutine(Routine routine) async {
    if (!routine.isActive || routine.isArchived) {
      await cancelRoutine(routine);
      return;
    }

    await _refreshTimezone();
    final notificationDetails = await _buildNotificationDetails(routine);
    // Cancel existing before rescheduling to avoid duplicates
    await cancelRoutine(routine);

    final exactCapability = await getExactAlarmCapability();
    final scheduleMode = (exactCapability == ExactAlarmCapability.available)
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;

    for (final reminderTime in routine.reminderTimes) {
      if (!reminderTime.isEnabled) continue;

      for (int weekday = 1; weekday <= 7; weekday++) {
        if (!routine.isScheduledForWeekday(weekday)) continue;

        // Unique notification ID per weekday & reminder time:
        // Base notificationId multiplied by 10 plus weekday
        final id = (reminderTime.notificationId * 10) + weekday;

        final nextDate = _nextInstanceOfWeekdayAndTime(
          weekday,
          reminderTime.hour,
          reminderTime.minute,
        );

        // Check date bounds
        if (routine.endDate != null && nextDate.isAfter(routine.endDate!)) {
          continue;
        }

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
        });

        try {
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
  }

  @override
  Future<void> cancelRoutine(Routine routine) async {
    for (final reminderTime in routine.reminderTimes) {
      for (int weekday = 1; weekday <= 7; weekday++) {
        final id = (reminderTime.notificationId * 10) + weekday;
        await cancelByNotificationId(id);
      }
    }
  }

  @override
  Future<void> cancelByNotificationId(int notificationId) async {
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
    }
  }

  @override
  Future<void> rescheduleAll(List<Routine> activeRoutines) async {
    AppLogger.info(
      'NotificationScheduler',
      'Rescheduling all active routines (${activeRoutines.length})',
    );
    await _notificationsPlugin.cancelAll();
    for (final routine in activeRoutines) {
      await scheduleRoutine(routine);
    }
  }

  @override
  Future<void> testNotification() async {
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
    if (Platform.isAndroid &&
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

  tz.TZDateTime _nextInstanceOfWeekdayAndTime(
    int targetWeekday,
    int hour,
    int minute,
  ) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Calculate days until target weekday (1=Mon ... 7=Sun)
    var daysUntilWeekday = (targetWeekday - scheduledDate.weekday) % 7;
    if (daysUntilWeekday < 0) {
      daysUntilWeekday += 7;
    }

    scheduledDate = scheduledDate.add(Duration(days: daysUntilWeekday));

    // If it's today and the time has already passed, schedule for next week
    if (daysUntilWeekday == 0 && scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate;
  }
}
