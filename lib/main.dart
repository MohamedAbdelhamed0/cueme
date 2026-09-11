import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'app/router/app_router.dart';

void main() async {
  late final BootstrapResult bootstrap;
  bootstrap = await bootstrapApp(
    onNotificationTapped: (payload) {
      try {
        final decoded = jsonDecode(payload) as Map<String, dynamic>;
        final routineId = decoded['routineId'] as String?;
        if (routineId != null) {
          final router = bootstrap.container.read(appRouterProvider);
          router.push('/reminder/ring?routineId=$routineId');
        }
      } catch (_) {}
    },
  );

  runApp(
    UncontrolledProviderScope(
      container: bootstrap.container,
      child: const CueMeApp(),
    ),
  );
}
