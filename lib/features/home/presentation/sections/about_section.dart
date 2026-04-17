import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/theme_context_extensions.dart';
import '../../../../core/widgets/max_width_box.dart';
import '../../../../core/widgets/section_header.dart';

/// About block: short self-intro on the left, headline stats on the right.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.responsive(mobile: 56, tablet: 72, desktop: 100),
      ),
      child: MaxWidthBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'About',
              title: AppStrings.sectionAbout,
              subtitle: AppStrings.aboutTitle,
            ),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = context.isDesktop;
                return Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: isDesktop ? 3 : 0,
                      child: Text(
                        AppStrings.aboutBody,
                        style: context.textStyle.openSansStyles.openSans16.copyWith(
                          color: context.colors.textColors.primary,
                          height: 1.6,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: isDesktop ? 64 : 0,
                        height: isDesktop ? 0 : 32),
                    Expanded(
                      flex: isDesktop ? 2 : 0,
                      child: const _Stats(),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats();

  @override
  Widget build(BuildContext context) {
    final items = [
      (value: '5+', label: 'Лет в Flutter'),
      (value: '15+', label: 'Доведённых проектов'),
      (value: '∞', label: 'Любви к чистому коду'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          _StatItem(value: items[i].value, label: items[i].label),
          if (i != items.length - 1)
            const Divider(height: 32, thickness: 0.5),
        ],
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 96,
          child: Text(
            value,
            style: context.textStyle.openSansStyles.extraBoldOpenSans36.copyWith(
              color: context.colors.mainColors.accent,
              letterSpacing: -0.5,
              height: 1.15,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              label,
              style: context.textStyle.openSansStyles.openSans14.copyWith(
                color: context.colors.textColors.secondary,
                height: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
