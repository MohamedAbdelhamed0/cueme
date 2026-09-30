import 'dart:async';
import 'package:cueme/app/providers/service_providers.dart';
import 'package:cueme/data/database/app_database.dart';
import 'package:cueme/domain/entities/routine.dart';
import 'package:cueme/domain/enums/reminder_enums.dart';
import 'package:cueme/presentation/controllers/routine_editor_controller.dart';
import 'package:cueme/presentation/pages/routine_editor/routine_editor_page.dart';
import 'package:cueme/services/notifications/reminder_scheduler.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late FakeScheduler scheduler;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    scheduler = FakeScheduler();
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        reminderSchedulerProvider.overrideWithValue(scheduler),
      ],
    );
  });
  tearDown(() async {
    container.dispose();
    await db.close();
  });

  RoutineEditorController editor() =>
      container.read(routineEditorControllerProvider(null).notifier);

  test(
    'Rejects duplicate add/edit times immediately and sorts accepted times',
    () {
      final controller = editor();
      expect(
        controller.addTime(const TimeOfDay(hour: 8, minute: 0)),
        isNotNull,
      );
      expect(controller.addTime(const TimeOfDay(hour: 6, minute: 0)), isNull);
      expect(
        controller.updateTimeAt(0, const TimeOfDay(hour: 8, minute: 0)),
        isNotNull,
      );
      expect(container.read(routineEditorControllerProvider(null)).times, [
        const TimeOfDay(hour: 6, minute: 0),
        const TimeOfDay(hour: 8, minute: 0),
      ]);
    },
  );

  test('Concurrent saves share one commit and one routine identity', () async {
    final controller = editor()..updateName('Test');
    scheduler.permissionGate = Completer<bool>();
    final first = controller.saveRoutine();
    final second = controller.saveRoutine();
    expect(identical(first, second), isTrue);
    await scheduler.permissionEntered.future;
    scheduler.permissionGate!.complete(true);
    expect((await first).success, isTrue);
    expect((await second).routine!.id, (await first).routine!.id);
    expect(
      (await container.read(routineRepositoryProvider).getAllActive()).length,
      1,
    );
    expect(scheduler.scheduled.length, 1);
  });

  test(
    'Permission denial preserves routine and returns recovery warning',
    () async {
      scheduler.permissionAllowed = false;
      final result = await (editor()..updateName('Test')).saveRoutine();
      expect(result.success, isTrue);
      expect(result.warning, 'Routine saved, reminders need attention');
      expect(
        await container
            .read(routineRepositoryProvider)
            .getById(result.routine!.id),
        isNotNull,
      );
    },
  );

  test(
    'Scheduling failure preserves save and a second save edits the same routine',
    () async {
      scheduler.failScheduling = true;
      final controller = editor()..updateName('Test');
      final first = await controller.saveRoutine();
      expect(first.success, isTrue);
      expect(first.warning, 'Routine saved, reminders need attention');
      scheduler.failScheduling = false;
      final second = await controller.saveRoutine();
      expect(second.warning, isNull);
      expect(second.routine!.id, first.routine!.id);
      expect(scheduler.cancelled.single.id, first.routine!.id);
      expect(
        (await container.read(routineRepositoryProvider).getAllActive()).length,
        1,
      );
    },
  );

  test('Missing pending alarms produce a recoverable save warning', () async {
    scheduler.missingAlarm = true;
    final result = await (editor()..updateName('Test')).saveRoutine();
    expect(result.success, isTrue);
    expect(result.warning, 'Routine saved, reminders need attention');
  });

  test(
    'Deleting a routine removes reminder rows with foreign keys off',
    () async {
      final result = await (editor()..updateName('Test')).saveRoutine();
      await container
          .read(routineRepositoryProvider)
          .deleteRoutine(result.routine!.id);
      expect(await db.select(db.reminderTimesTable).get(), isEmpty);
    },
  );

  testWidgets(
    'Name validation is inline and duplicate Save is disabled while saving',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(420, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: RoutineEditorPage()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('Routine name is required'), findsOneWidget);
      await tester.enterText(find.byType(TextField).first, 'Test');
      scheduler.permissionGate = Completer<bool>();
      await tester.tap(find.text('Save'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        tester
            .widget<TextButton>(
              find.descendant(
                of: find.byType(AppBar),
                matching: find.byType(TextButton),
              ),
            )
            .onPressed,
        isNull,
      );
      await tester.runAsync(() => scheduler.permissionEntered.future);
      await tester.runAsync(() async {
        scheduler.permissionGate!.complete(false);
        await Future<void>.delayed(const Duration(milliseconds: 100));
      });
      await tester.pumpAndSettle();
      expect(
        find.text('Routine saved, reminders need attention'),
        findsOneWidget,
      );
      expect(find.text('Retry reminders'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}

class FakeScheduler implements ReminderScheduler {
  bool permissionAllowed = true;
  bool failScheduling = false;
  bool missingAlarm = false;
  Completer<bool>? permissionGate;
  final permissionEntered = Completer<void>();
  final scheduled = <Routine>[];
  final cancelled = <Routine>[];
  @override
  Future<bool> requestNotificationPermission() async {
    if (!permissionEntered.isCompleted) permissionEntered.complete();
    return permissionGate == null
        ? permissionAllowed
        : await permissionGate!.future;
  }

  @override
  Future<ScheduleVerification> scheduleRoutine(Routine routine) async {
    scheduled.add(routine);
    if (failScheduling) throw StateError('Scheduling failed');
    return ScheduleVerification({1}, missingAlarm ? {} : {1});
  }

  @override
  Future<void> cancelRoutine(Routine routine) async => cancelled.add(routine);
  @override
  Future<ExactAlarmCapability> getExactAlarmCapability() async =>
      ExactAlarmCapability.available;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
