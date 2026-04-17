import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../core/theme/theme_context_extensions.dart';
import '../../../../core/widgets/max_width_box.dart';
import '../../../../core/widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.responsive(mobile: 56, tablet: 80, desktop: 120),
      ),
      child: MaxWidthBox(
        child: Container(
          padding: EdgeInsets.all(
            context.responsive(mobile: 28, tablet: 48, desktop: 64),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.mainColors.accent.withValues(alpha: 0.12),
                colors.mainColors.accentSecondary.withValues(alpha: 0.04),
              ],
            ),
            border: Border.all(
              color: colors.mainColors.accent.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                label: 'Contact',
                title: AppStrings.contactTitle,
                subtitle: AppStrings.contactBody,
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _ContactButton(
                    icon: Icons.email_outlined,
                    label: AppStrings.contactEmail,
                    url: 'mailto:${AppStrings.contactEmail}',
                    filled: true,
                  ),
                  _ContactButton(
                    icon: Icons.code,
                    label: 'GitHub',
                    url: AppStrings.contactGithub,
                  ),
                  _ContactButton(
                    icon: Icons.send_outlined,
                    label: 'Telegram',
                    url: AppStrings.contactTelegram,
                  ),
                  _ContactButton(
                    icon: Icons.business_center_outlined,
                    label: 'LinkedIn',
                    url: AppStrings.contactLinkedIn,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.icon,
    required this.label,
    required this.url,
    this.filled = false,
  });

  final IconData icon;
  final String label;
  final String url;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Future<void> launch() async {
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 10),
        Text(label),
      ],
    );

    if (filled) {
      return FilledButton(onPressed: launch, style: style, child: child);
    }
    return OutlinedButton(onPressed: launch, style: style, child: child);
  }
}
