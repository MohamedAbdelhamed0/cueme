import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers/service_providers.dart';
import '../../domain/enums/reminder_enums.dart';
import '../../services/permissions/permission_service.dart';

final permissionHealthProvider = FutureProvider.autoDispose<PermissionStatusOverview>((ref) async {
  final permissionService = ref.watch(permissionServiceProvider);
  return permissionService.checkHealth();
});

class SettingsController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> updateThemeMode(ThemePreference mode) async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final current = await settingsRepo.getSettings();
    await settingsRepo.updateSettings(current.copyWith(themeMode: mode));
  }

  Future<void> updateTimeFormat(TimeFormatPreference format) async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final current = await settingsRepo.getSettings();
    await settingsRepo.updateSettings(current.copyWith(timeFormat: format));
  }

  Future<void> updateDynamicColor(bool enabled) async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final current = await settingsRepo.getSettings();
    await settingsRepo.updateSettings(current.copyWith(useDynamicColor: enabled));
  }

  Future<void> updateDefaultSnooze(int minutes) async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final current = await settingsRepo.getSettings();
    await settingsRepo.updateSettings(current.copyWith(defaultSnoozeMinutes: minutes));
  }

  Future<void> updateDefaultVibration(bool enabled) async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final current = await settingsRepo.getSettings();
    await settingsRepo.updateSettings(current.copyWith(defaultVibration: enabled));
  }

  Future<void> completeOnboarding() async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final current = await settingsRepo.getSettings();
    await settingsRepo.updateSettings(current.copyWith(onboardingCompleted: true));
  }

  Future<void> triggerTestNotification() async {
    final scheduler = ref.read(reminderSchedulerProvider);
    await scheduler.testNotification();
  }
}

final settingsControllerProvider = NotifierProvider<SettingsController, AsyncValue<void>>(SettingsController.new);
