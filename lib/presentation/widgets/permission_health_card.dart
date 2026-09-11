import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers/service_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_tokens.dart';
import '../controllers/settings_controller.dart';

class PermissionHealthCard extends ConsumerWidget {
  const PermissionHealthCard({super.key});

  Widget _buildRow({
    required BuildContext context,
    required String label,
    required bool isReady,
    required String readyText,
    required String actionText,
    VoidCallback? onFix,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            isReady ? Icons.check_circle_rounded : Icons.warning_amber_rounded,
            size: 18,
            color: isReady ? AppColors.statusDone : AppColors.statusDue,
          ),
          const SizedBox(width: AppTokens.s12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            isReady ? readyText : actionText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isReady
                  ? (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)
                  : AppColors.statusDue,
            ),
          ),
          if (!isReady && onFix != null) ...[
            const SizedBox(width: 8),
            InkWell(
              onTap: onFix,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  'Fix',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final healthAsync = ref.watch(permissionHealthProvider);
    final permissionService = ref.watch(permissionServiceProvider);

    return Container(
      padding: const EdgeInsets.all(AppTokens.s20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: AppTokens.borderRadiusLg,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: AppTokens.softShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.health_and_safety_outlined, color: AppColors.primary, size: 22),
              const SizedBox(width: AppTokens.s8),
              Text(
                'Reminder Health',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh_rounded, size: 18),
                tooltip: 'Refresh Status',
                onPressed: () => ref.invalidate(permissionHealthProvider),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.s8),
          const Divider(height: 1),
          const SizedBox(height: AppTokens.s8),
          healthAsync.when(
            data: (overview) {
              return Column(
                children: [
                  _buildRow(
                    context: context,
                    label: 'Notifications',
                    isReady: overview.notificationsAllowed,
                    readyText: 'Allowed',
                    actionText: 'Action Needed',
                    onFix: () async {
                      await permissionService.requestNotifications();
                      ref.invalidate(permissionHealthProvider);
                    },
                  ),
                  _buildRow(
                    context: context,
                    label: 'Precise Reminders',
                    isReady: overview.exactAlarmAllowed,
                    readyText: 'Ready',
                    actionText: 'Attention Needed',
                    onFix: () async {
                      await permissionService.requestExactAlarm();
                      ref.invalidate(permissionHealthProvider);
                    },
                  ),
                  _buildRow(
                    context: context,
                    label: 'Microphone',
                    isReady: overview.microphoneAllowed,
                    readyText: 'Ready',
                    actionText: 'Not Requested',
                    onFix: () async {
                      await permissionService.requestMicrophone();
                      ref.invalidate(permissionHealthProvider);
                    },
                  ),
                  _buildRow(
                    context: context,
                    label: 'Battery Optimization',
                    isReady: overview.batteryOptimizationIgnored,
                    readyText: 'Normal',
                    actionText: 'May Delay Alarms',
                    onFix: () async {
                      await permissionService.requestIgnoreBatteryOptimizations();
                      ref.invalidate(permissionHealthProvider);
                    },
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (err, _) => Text(
              'Could not check status: $err',
              style: const TextStyle(color: AppColors.statusMissed, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
