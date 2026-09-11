import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionStatusOverview {
  final bool notificationsAllowed;
  final bool microphoneAllowed;
  final bool exactAlarmAllowed;
  final bool batteryOptimizationIgnored;

  const PermissionStatusOverview({
    required this.notificationsAllowed,
    required this.microphoneAllowed,
    required this.exactAlarmAllowed,
    required this.batteryOptimizationIgnored,
  });
}

class PermissionService {
  Future<PermissionStatusOverview> checkHealth() async {
    final notifStatus = await Permission.notification.status;
    final micStatus = await Permission.microphone.status;

    bool exactAlarm = true;
    bool battery = true;

    if (Platform.isAndroid) {
      final alarmStatus = await Permission.scheduleExactAlarm.status;
      exactAlarm = alarmStatus.isGranted;
      final batteryStatus = await Permission.ignoreBatteryOptimizations.status;
      battery = batteryStatus.isGranted;
    }

    return PermissionStatusOverview(
      notificationsAllowed: notifStatus.isGranted,
      microphoneAllowed: micStatus.isGranted,
      exactAlarmAllowed: exactAlarm,
      batteryOptimizationIgnored: battery,
    );
  }

  Future<bool> requestNotifications() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<bool> requestMicrophone() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> requestExactAlarm() async {
    if (Platform.isAndroid) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  Future<void> requestIgnoreBatteryOptimizations() async {
    if (Platform.isAndroid) {
      await Permission.ignoreBatteryOptimizations.request();
    }
  }

  Future<void> openAppSettingsPage() async {
    await openAppSettings();
  }
}
