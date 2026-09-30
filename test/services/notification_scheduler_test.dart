import 'dart:async';
import 'dart:convert';
import 'package:cueme/domain/entities/routine.dart';
import 'package:cueme/domain/entities/reminder_time.dart';
import 'package:cueme/domain/enums/routine_category.dart';
import 'package:cueme/domain/repositories/routine_repository.dart';
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
  final pending = <int, Map<String, dynamic>>{};
  int? dropId;
  Completer<void>? scheduleGate;

  setUp(() {
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    calls.clear();
    pending.clear();
    dropId = null;
    scheduleGate = null;
    zone = 'Africa/Cairo';
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(timezone, (_) async => zone);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(notifications, (call) async {
          calls.add(call);
          final args = call.arguments;
          if (call.method == 'zonedSchedule') {
            if (scheduleGate != null) await scheduleGate!.future;
            final map = Map<String, dynamic>.from(args as Map);
            if (map['id'] != dropId) pending[map['id'] as int] = map;
            return null;
          }
          if (call.method == 'cancel') pending.remove((args as Map)['id']);
          if (call.method == 'cancelAll') pending.clear();
          if (call.method == 'pendingNotificationRequests') {
            return pending.values
                .map(
                  (item) => {
                    'id': item['id'],
                    'title': item['title'],
                    'body': item['body'],
                    'payload': item['payload'],
                  },
                )
                .toList();
          }
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
  Routine routine({
    List<int> ids = const [1001, 1002, 1003],
    int mask = 127,
    DateTime? start,
    DateTime? end,
  }) {
    final now = DateTime.now();
    return Routine(
      id: 'routine',
      name: 'Test',
      category: RoutineCategory.pill,
      iconKey: 'pill',
      colorKey: 'blue',
      startDate: start ?? now,
      endDate: end,
      weekdaysMask: mask,
      createdAt: now,
      updatedAt: now,
      reminderTimes: [
        for (var i = 0; i < ids.length; i++)
          ReminderTime(
            id: 'time-${ids[i]}',
            routineId: 'routine',
            hour: 8 + i * 4,
            minute: 0,
            notificationId: ids[i],
            createdAt: now,
            updatedAt: now,
          ),
      ],
    );
  }

  test('Every chosen time has seven independent weekly alarms', () async {
    final scheduler = FlutterLocalNotificationScheduler();
    await scheduler.initialize();
    final result = await scheduler.scheduleRoutine(routine());
    expect(result.expectedIds.length, 21);
    expect(result.isComplete, isTrue);
    final schedules = calls.where((c) => c.method == 'zonedSchedule').toList();
    expect(schedules.length, 21);
    for (final call in schedules) {
      expect(
        (call.arguments as Map)['matchDateTimeComponents'],
        DateTimeComponents.dayOfWeekAndTime.index,
      );
    }
    // A delivered occurrence is advanced by Android under the same ID. Other
    // times must retain distinct payloads and IDs, rather than being replaced.
    expect(
      pending.values
          .map((p) => jsonDecode(p['payload'] as String)['reminderTimeId'])
          .toSet()
          .length,
      3,
    );
  });

  test(
    'Resume preserves valid pending alarms instead of cancelling due delivery',
    () async {
      final scheduler = FlutterLocalNotificationScheduler();
      await scheduler.initialize();
      final source = routine();
      await scheduler.scheduleRoutine(source);
      calls.clear();
      await scheduler.scheduleRoutine(source);
      await scheduler.rescheduleAll([source]);
      expect(
        calls.where(
          (c) =>
              c.method == 'cancel' ||
              c.method == 'cancelAll' ||
              c.method == 'zonedSchedule',
        ),
        isEmpty,
      );
      expect(pending.length, 21);
    },
  );

  test('Selected weekdays only and disabled times do not schedule', () async {
    final scheduler = FlutterLocalNotificationScheduler();
    await scheduler.initialize();
    final source = routine(mask: Routine.maskFromWeekdays({1, 5}));
    final result = await scheduler.scheduleRoutine(
      source.copyWith(
        reminderTimes: [
          source.reminderTimes.first,
          source.reminderTimes.last.copyWith(isEnabled: false),
        ],
      ),
    );
    expect(result.expectedIds, {10011, 10015});
  });

  test(
    'Future starts retain their first date through native weekly repeat',
    () async {
      final scheduler = FlutterLocalNotificationScheduler();
      await scheduler.initialize();
      final start = DateTime.now().add(const Duration(days: 30));
      await scheduler.scheduleRoutine(routine(start: start));
      final schedules = calls.where((c) => c.method == 'zonedSchedule');
      for (final call in schedules) {
        final args = call.arguments as Map;
        expect(args['matchDateTimeComponents'], isNull);
        expect(args['scheduledNotificationRepeatFrequency'], 1);
        expect(
          DateTime.parse(
            args['scheduledDateTime'] as String,
          ).isBefore(DateTime(start.year, start.month, start.day)),
          isFalse,
        );
      }
    },
  );

  test(
    'Missing alarms are reported instead of successful scheduling',
    () async {
      final scheduler = FlutterLocalNotificationScheduler();
      await scheduler.initialize();
      dropId = 10011;
      await expectLater(scheduler.scheduleRoutine(routine()), throwsStateError);
      dropId = null;
      expect((await scheduler.scheduleRoutine(routine())).isComplete, isTrue);
    },
  );

  test('Cancellation waits for an in-progress scheduling operation', () async {
    final scheduler = FlutterLocalNotificationScheduler();
    await scheduler.initialize();
    scheduleGate = Completer<void>();
    final scheduling = scheduler.scheduleRoutine(routine());
    await Future<void>.delayed(const Duration(milliseconds: 10));
    final cancelling = scheduler.cancelRoutine(routine());
    expect(calls.where((c) => c.method == 'zonedSchedule').length, 1);
    scheduleGate!.complete();
    await scheduling;
    await cancelling;
    expect(pending, isEmpty);
  });

  test(
    'Queued startup rebuild reloads latest saved rows, not stale snapshot',
    () async {
      final repo = TestRoutineRepository(routine());
      final scheduler = FlutterLocalNotificationScheduler(
        routineRepository: repo,
      );
      await scheduler.initialize();
      final stale = repo.current;
      scheduleGate = Completer<void>();
      final first = scheduler.scheduleRoutine(stale);
      await Future<void>.delayed(const Duration(milliseconds: 10));
      final rebuild = scheduler.rescheduleAll([stale]);
      repo.current = routine(ids: [1101, 1102]);
      scheduleGate!.complete();
      await first;
      await rebuild;
      expect(pending.length, 14);
      expect(pending.keys.any((id) => id < 11010), isFalse);
    },
  );

  test(
    'Editing removes previous time IDs and preserves other routine alarms',
    () async {
      final scheduler = FlutterLocalNotificationScheduler();
      await scheduler.initialize();
      await scheduler.scheduleRoutine(routine());
      await scheduler.cancelRoutine(routine());
      await scheduler.scheduleRoutine(routine(ids: [2001, 2002]));
      expect(pending.length, 14);
      expect(pending.keys.any((id) => id < 20010), isFalse);
    },
  );
}

class TestRoutineRepository implements RoutineRepository {
  Routine current;
  TestRoutineRepository(this.current);
  @override
  Future<Routine?> getById(String id) async => current;
  @override
  Future<List<Routine>> getAllActive() async => [current];
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
