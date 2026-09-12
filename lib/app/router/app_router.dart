import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/history/history_page.dart';
import '../../presentation/pages/onboarding/onboarding_page.dart';
import '../../presentation/pages/reminder_ring/reminder_ring_page.dart';
import '../../presentation/pages/routine_editor/routine_editor_page.dart';
import '../../presentation/pages/routines/routines_page.dart';
import '../../presentation/pages/settings/settings_page.dart';
import '../../presentation/pages/today/today_page.dart';
import '../../presentation/widgets/app_scaffold.dart';
import '../providers/service_providers.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _todayNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'todayNav');
final GlobalKey<NavigatorState> _routinesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'routinesNav');
final GlobalKey<NavigatorState> _historyNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'historyNav');
final GlobalKey<NavigatorState> _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settingsNav');

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {
    _ref.listen(appSettingsStreamProvider, (_, _) => notifyListeners());
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final settings = _ref.read(appSettingsStreamProvider).value;
    if (settings != null && !settings.onboardingCompleted) {
      if (!state.matchedLocation.startsWith('/onboarding')) {
        return '/onboarding';
      }
    }
    return null;
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) => RouterNotifier(ref));

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: notifier,
    initialLocation: '/today',
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/onboarding',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/routine/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const RoutineEditorPage(),
      ),
      GoRoute(
        path: '/routine/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return RoutineEditorPage(routineId: id);
        },
      ),
      GoRoute(
        path: '/reminder/ring',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final routineId = state.uri.queryParameters['routineId'];
          return ReminderRingPage(routineId: routineId);
        },
      ),

      // Stateful Bottom Navigation Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _todayNavigatorKey,
            routes: [
              GoRoute(
                path: '/today',
                builder: (context, state) => const TodayPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _routinesNavigatorKey,
            routes: [
              GoRoute(
                path: '/routines',
                builder: (context, state) => const RoutinesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _historyNavigatorKey,
            routes: [
              GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
