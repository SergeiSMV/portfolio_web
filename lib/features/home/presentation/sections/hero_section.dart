import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/theme_context_extensions.dart';
import '../../../../core/widgets/max_width_box.dart';

/// Top hero: badge → huge title → subtitle → primary CTAs.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final heroTitleStyle = context.responsive<TextStyle>(
      mobile: context.textStyle.openSansStyles.extraBoldOpenSans40,
      tablet: context.textStyle.openSansStyles.extraBoldOpenSans64,
      desktop: context.textStyle.openSansStyles.extraBoldOpenSans84,
    );
    final subtitleStyle = context.responsive<TextStyle>(
      mobile: context.textStyle.openSansStyles.openSans16,
      tablet: context.textStyle.openSansStyles.openSans18,
      desktop: context.textStyle.openSansStyles.openSans20,
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
              style: heroTitleStyle.copyWith(
                height: 1.0,
                color: context.colors.textColors.primary,
                letterSpacing: -1.5,
              ),
            ),
            const SizedBox(height: 8),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  colors.mainColors.accent,
                  colors.mainColors.accentSecondary,
                ],
              ).createShader(bounds),
              child: Text(
                AppStrings.heroTitleLine2,
                style: heroTitleStyle.copyWith(
                  height: 1.0,
                  color: colors.mainColors.onPrimary,
                  letterSpacing: -1.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                AppStrings.heroSubtitle,
                style: subtitleStyle.copyWith(
                  color: context.colors.textColors.primary,
                  height: 1.6,
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
                    side: BorderSide(color: colors.elementColors.divider),
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
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: colors.mainColors.accentSecondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: colors.mainColors.accentSecondary.withValues(alpha: 0.3),
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
              color: colors.mainColors.accentSecondary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            AppStrings.availabilityBadge,
            style: context.textStyle.openSansStyles.semiBoldOpenSans12
                .copyWith(color: colors.mainColors.accentSecondary),
          ),
        ],
      ),
    );
  }
}
