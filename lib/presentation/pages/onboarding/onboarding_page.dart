import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/service_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../controllers/settings_controller.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _finishOnboarding() async {
    await ref.read(settingsControllerProvider.notifier).completeOnboarding();
    if (mounted) {
      context.go('/today');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Page indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(3, (index) {
                      return AnimatedContainer(
                        duration: AppTokens.durationFast,
                        margin: const EdgeInsets.only(right: 6),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : (isDark ? AppColors.darkSurfaceSoft : AppColors.lightSurfaceSoft),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  if (_currentPage < 2)
                    TextButton(
                      onPressed: _finishOnboarding,
                      child: const Text('Skip'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  // Step 1: Welcome
                  _buildSlide(
                    context: context,
                    icon: Icons.alarm_on_rounded,
                    imageAsset: 'assets/icon/app_icon.png',
                    title: 'Your routines,\non time.',
                    description:
                        'CueMe helps you stay on track with pills, vitamins, skincare, and daily habits with calm, reliable local reminders.',
                    features: const [
                      '100% offline — your data never leaves your device',
                      'Personalized recorded voice reminders',
                      'No account, no tracking, zero friction',
                    ],
                    buttonText: 'Get Started',
                    onPressed: () {
                      _pageController.nextPage(
                        duration: AppTokens.durationMedium,
                        curve: Curves.easeInOut,
                      );
                    },
                  ),

                  // Step 2: Notifications
                  _buildSlide(
                    context: context,
                    icon: Icons.notifications_active_outlined,
                    title: 'Never miss a\nmoment.',
                    description:
                        'CueMe delivers timely, precise alerts straight to your lock screen so you never forget your next routine.',
                    features: const [
                      'Scheduled at your exact preferred wall-clock times',
                      'Actionable buttons for Done and Snooze',
                      'You remain in control of reminder permissions',
                    ],
                    buttonText: 'Enable Notifications',
                    secondaryButtonText: 'Not Now',
                    onPressed: () async {
                      final permissionService = ref.read(permissionServiceProvider);
                      await permissionService.requestNotifications();
                      _pageController.nextPage(
                        duration: AppTokens.durationMedium,
                        curve: Curves.easeInOut,
                      );
                    },
                    onSecondaryPressed: () {
                      _pageController.nextPage(
                        duration: AppTokens.durationMedium,
                        curve: Curves.easeInOut,
                      );
                    },
                  ),

                  // Step 3: Voice Reminders
                  _buildSlide(
                    context: context,
                    icon: Icons.mic_rounded,
                    title: 'Voice-first\nreminders.',
                    description:
                        'Record a short 5-second voice clip for any routine. Hear your own friendly voice instead of an annoying generic chime.',
                    features: const [
                      '“Take your Vitamin D after breakfast!”',
                      '“Time for your evening night cream”',
                      'Preview, re-record, or delete any time',
                    ],
                    buttonText: 'Start Creating Routines',
                    onPressed: _finishOnboarding,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide({
    required BuildContext context,
    required IconData icon,
    String? imageAsset,
    required String title,
    required String description,
    required List<String> features,
    required String buttonText,
    String? secondaryButtonText,
    required VoidCallback onPressed,
    VoidCallback? onSecondaryPressed,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTokens.s32, vertical: AppTokens.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          if (imageAsset != null)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(imageAsset, fit: BoxFit.cover),
              ),
            )
          else
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: AppTokens.borderRadiusLg,
              ),
              child: Icon(icon, size: 36, color: AppColors.primary),
            ),
          const SizedBox(height: AppTokens.s24),
          Text(
            title,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
              height: 1.15,
            ),
          ),
          const SizedBox(height: AppTokens.s12),
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppTokens.s24),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_rounded, size: 18, color: AppColors.statusDone),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      f,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 2),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: AppTokens.borderRadiusMd),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          if (secondaryButtonText != null && onSecondaryPressed != null) ...[
            const SizedBox(height: AppTokens.s8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onSecondaryPressed,
                child: Text(secondaryButtonText),
              ),
            ),
          ],
          const SizedBox(height: AppTokens.s16),
        ],
      ),
    );
  }
}
