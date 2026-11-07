import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';

/// Brand splash shown while stored transactions load.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: c.hero,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(scale: 0.92 + 0.08 * value, child: child),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: c.onHero,
                          borderRadius: BorderRadius.circular(AppRadius.xl + 4),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 48,
                          color: c.hero,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        AppStrings.appName,
                        style: t.titleLarge!.copyWith(color: c.onHero, fontSize: 28),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.tagline,
                        style: t.bodyMedium!.copyWith(color: c.onHero.withValues(alpha: 0.88)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5, color: c.onHero),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
