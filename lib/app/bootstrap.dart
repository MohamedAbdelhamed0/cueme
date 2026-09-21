import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/app_logger.dart';
import 'providers/service_providers.dart';

class BootstrapResult {
  final ProviderContainer container;

  BootstrapResult(this.container);
}

Future<BootstrapResult> bootstrapApp({
  void Function(String payload)? onNotificationTapped,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  try {
    AppLogger.info('Bootstrap', 'Initializing AudioStorageService...');
    final audioStorage = container.read(audioStorageServiceProvider);
    await audioStorage.initialize();

    AppLogger.info('Bootstrap', 'Initializing ReminderScheduler...');
    final scheduler = container.read(reminderSchedulerProvider);
    await scheduler.initialize(onNotificationTapped: onNotificationTapped);

    // Run reconciliation in background without blocking app render
    Future.microtask(() async {
      final syncService = container.read(notificationSyncServiceProvider);
      await syncService.reconcile(rebuildAll: true);
    });
  } catch (e, st) {
    AppLogger.error('Bootstrap', 'Initialization error', e, st);
  }

  return BootstrapResult(container);
}
