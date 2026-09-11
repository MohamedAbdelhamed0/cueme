import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/service_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../domain/enums/reminder_enums.dart';
import '../../controllers/settings_controller.dart';
import '../../widgets/permission_health_card.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppTokens.s20, AppTokens.s20, AppTokens.s20, AppTokens.s8),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppTokens.s20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: AppTokens.borderRadiusLg,
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settingsAsync = ref.watch(appSettingsStreamProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final permissionService = ref.watch(permissionServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: settingsAsync.when(
        data: (settings) {
          return ListView(
            padding: const EdgeInsets.only(bottom: AppTokens.s48),
            children: [
              // Reminder Health Card at the top
              const Padding(
                padding: EdgeInsets.fromLTRB(AppTokens.s20, AppTokens.s8, AppTokens.s20, 0),
                child: PermissionHealthCard(),
              ),

              // Appearance Section
              _buildSection(
                context,
                'APPEARANCE',
                [
                  ListTile(
                    leading: const Icon(Icons.palette_outlined),
                    title: const Text('Theme Mode'),
                    trailing: DropdownButton<ThemePreference>(
                      value: settings.themeMode,
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem(value: ThemePreference.system, child: Text('System')),
                        DropdownMenuItem(value: ThemePreference.light, child: Text('Light')),
                        DropdownMenuItem(value: ThemePreference.dark, child: Text('Dark')),
                      ],
                      onChanged: (mode) {
                        if (mode != null) controller.updateThemeMode(mode);
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile.adaptive(
                    secondary: const Icon(Icons.color_lens_outlined),
                    title: const Text('Dynamic Color'),
                    subtitle: const Text('Use wallpaper tones where supported'),
                    value: settings.useDynamicColor,
                    activeTrackColor: AppColors.primary,
                    onChanged: controller.updateDynamicColor,
                  ),
                ],
              ),

              // Reminders Section
              _buildSection(
                context,
                'REMINDERS',
                [
                  ListTile(
                    leading: const Icon(Icons.snooze_rounded),
                    title: const Text('Default Snooze'),
                    trailing: DropdownButton<int>(
                      value: settings.defaultSnoozeMinutes,
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem(value: 5, child: Text('5 min')),
                        DropdownMenuItem(value: 10, child: Text('10 min')),
                        DropdownMenuItem(value: 15, child: Text('15 min')),
                        DropdownMenuItem(value: 30, child: Text('30 min')),
                      ],
                      onChanged: (val) {
                        if (val != null) controller.updateDefaultSnooze(val);
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile.adaptive(
                    secondary: const Icon(Icons.vibration_rounded),
                    title: const Text('Default Vibration'),
                    value: settings.defaultVibration,
                    activeTrackColor: AppColors.primary,
                    onChanged: controller.updateDefaultVibration,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.settings_suggest_outlined),
                    title: const Text('Device Notification Settings'),
                    trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                    onTap: () => permissionService.openAppSettingsPage(),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications_active_outlined),
                    title: const Text('Send Test Reminder'),
                    subtitle: const Text('Verify that alerts pop up cleanly'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () async {
                      await controller.triggerTestNotification();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Test reminder scheduled! Check your notifications.')),
                        );
                      }
                    },
                  ),
                ],
              ),

              // Time Format
              _buildSection(
                context,
                'TIME FORMAT',
                [
                  ListTile(
                    leading: const Icon(Icons.schedule_rounded),
                    title: const Text('Display Format'),
                    trailing: DropdownButton<TimeFormatPreference>(
                      value: settings.timeFormat,
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem(value: TimeFormatPreference.system, child: Text('Device Default')),
                        DropdownMenuItem(value: TimeFormatPreference.twelveHour, child: Text('12-Hour (AM/PM)')),
                        DropdownMenuItem(value: TimeFormatPreference.twentyFourHour, child: Text('24-Hour')),
                      ],
                      onChanged: (val) {
                        if (val != null) controller.updateTimeFormat(val);
                      },
                    ),
                  ),
                ],
              ),

              // Data & History
              _buildSection(
                context,
                'DATA & PRIVACY',
                [
                  ListTile(
                    leading: const Icon(Icons.delete_sweep_outlined, color: AppColors.statusMissed),
                    title: const Text('Clear All History', style: TextStyle(color: AppColors.statusMissed)),
                    subtitle: const Text('Remove logged completions and skips'),
                    onTap: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Clear History?'),
                          content: const Text('All previous action logs will be removed. Your active routines will remain intact.'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                            FilledButton(
                              style: FilledButton.styleFrom(backgroundColor: AppColors.statusMissed),
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Clear'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true) {
                        await ref.read(historyRepositoryProvider).clearHistory();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('History cleared')),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),

              // About Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTokens.s20, vertical: AppTokens.s24),
                child: Column(
                  children: [
                    Text(
                      'CueMe v1.0.0',
                      style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your routine and voice data stay on this device.\nNo accounts. No trackers. 100% offline.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: AppColors.lightTextSecondary),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error loading settings: $err')),
      ),
    );
  }
}
