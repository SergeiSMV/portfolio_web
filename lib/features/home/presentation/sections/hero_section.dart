import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/widgets/max_width_box.dart';

/// Top hero: badge → huge title → subtitle → primary CTAs.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleSize = context.responsive<double>(
      mobile: 40,
      tablet: 64,
      desktop: 84,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.responsive(mobile: 56, tablet: 96, desktop: 140),
      ),
      child: MaxWidthBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _AvailabilityBadge(),
            const SizedBox(height: 32),
            Text(
              AppStrings.heroTitleLine1,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: titleSize,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
              ).createShader(bounds),
              child: Text(
                AppStrings.heroTitleLine2,
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: titleSize,
                  height: 1.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                AppStrings.heroSubtitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: context.responsive(
                      mobile: 16, tablet: 18, desktop: 20),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () =>
                      GoRouter.of(context).go(AppRoutes.projects),
                  child: const Text(AppStrings.ctaProjects),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(color: theme.colorScheme.outline),
                  ),
                  onPressed: () {},
                  child: const Text(AppStrings.ctaContact),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  const _AvailabilityBadge();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: theme.colorScheme.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            AppStrings.availabilityBadge,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
