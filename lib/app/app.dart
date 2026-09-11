import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../domain/enums/reminder_enums.dart';
import 'providers/service_providers.dart';
import 'router/app_router.dart';

class CueMeApp extends ConsumerStatefulWidget {
  const CueMeApp({super.key});

  @override
  ConsumerState<CueMeApp> createState() => _CueMeAppState();
}

class _CueMeAppState extends ConsumerState<CueMeApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reconcile notifications and refresh Today on resume
      ref.read(notificationSyncServiceProvider).reconcile();
      ref.invalidate(todayOccurrencesProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final settingsAsync = ref.watch(appSettingsStreamProvider);

    final settings = settingsAsync.value;
    final themeMode = switch (settings?.themeMode) {
      ThemePreference.light => ThemeMode.light,
      ThemePreference.dark => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    final useDynamicColor = settings?.useDynamicColor ?? false;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ThemeData lightTheme = AppTheme.lightTheme;
        ThemeData darkTheme = AppTheme.darkTheme;

        if (useDynamicColor && lightDynamic != null && darkDynamic != null) {
          lightTheme = lightTheme.copyWith(colorScheme: lightDynamic);
          darkTheme = darkTheme.copyWith(colorScheme: darkDynamic);
        }

        return MaterialApp.router(
          title: 'CueMe',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
