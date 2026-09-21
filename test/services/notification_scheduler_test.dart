import 'package:cueme/services/notifications/flutter_local_notification_scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/timezone.dart' as tz;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const notifications = MethodChannel(
    'dexterous.com/flutter/local_notifications',
  );
  const timezone = MethodChannel('flutter_timezone');
  final calls = <MethodCall>[];
  var zone = 'Africa/Cairo';

  setUp(() {
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    calls.clear();
    zone = 'Africa/Cairo';
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(timezone, (_) async => zone);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(notifications, (call) async {
          calls.add(call);
          return true;
        });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    for (final channel in [notifications, timezone]) {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    }
  });

  test(
    'Uses device timezone and schedules test through OS for later delivery',
    () async {
      final scheduler = FlutterLocalNotificationScheduler();
      await scheduler.initialize();
      expect(tz.local.name, 'Africa/Cairo');
      final before = tz.TZDateTime.now(tz.local);
      await scheduler.testNotification();
      final call = calls.singleWhere((call) => call.method == 'zonedSchedule');
      final args = Map<String, dynamic>.from(call.arguments as Map);
      expect(args['timeZoneName'], 'Africa/Cairo');
      expect(
        (args['platformSpecifics'] as Map)['scheduleMode'],
        'exactAllowWhileIdle',
      );
      expect(calls.any((call) => call.method == 'show'), isFalse);
      final date = DateTime.parse(args['scheduledDateTime'] as String);
      expect(date.hour, before.add(const Duration(seconds: 30)).hour);
      expect(date.minute, before.add(const Duration(seconds: 30)).minute);
    },
  );

  test('Refreshes timezone after the device timezone changes', () async {
    final scheduler = FlutterLocalNotificationScheduler();
    await scheduler.initialize();
    zone = 'Asia/Tokyo';
    await scheduler.testNotification();
    final call = calls.singleWhere((call) => call.method == 'zonedSchedule');
    expect((call.arguments as Map)['timeZoneName'], 'Asia/Tokyo');
  });
}
