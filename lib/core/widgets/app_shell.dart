import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';
import '../theme/colors/theme_cubit.dart';
import '../theme/theme_context_extensions.dart';
import '../constants/app_strings.dart';
import '../responsive/breakpoints.dart';

/// Top-level scaffold shared by every route: app bar + optional mobile
/// drawer + routed body. Wrapped around the router via [ShellRoute].
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: _AppTopBar(isMobile: isMobile),
      ),
      endDrawer: isMobile ? const _MobileDrawer() : null,
      body: child,
    );
  }
}

// -----------------------------------------------------------------------------
// Top bar
// -----------------------------------------------------------------------------

class _AppTopBar extends StatelessWidget {
  const _AppTopBar({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isVeryNarrow = MediaQuery.sizeOf(context).width < 380;
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withValues(alpha: 0.9),
        border: Border(
          bottom: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsive(
                  mobile: isVeryNarrow ? 12 : 20,
                  tablet: 32,
                  desktop: 48,
                ),
              ),
              child: Row(
                children: [
                  _Logo(
                    compact: isVeryNarrow,
                    onTap: () => GoRouter.of(context).go(AppRoutes.home),
                  ),
                  const Spacer(),
                  if (!isMobile) ...[
                    _NavLink(
                      label: AppStrings.navHome,
                      onTap: () =>
                          GoRouter.of(context).go(AppRoutes.home),
                    ),
                    const SizedBox(width: 24),
                    _NavLink(
                      label: AppStrings.navProjects,
                      onTap: () =>
                          GoRouter.of(context).go(AppRoutes.projects),
                    ),
                    const SizedBox(width: 16),
                  ],
                  _ThemeToggle(compact: isVeryNarrow),
                  if (isMobile) ...[
                    SizedBox(width: isVeryNarrow ? 0 : 4),
                    Builder(
                      builder: (ctx) => IconButton(
                        constraints: BoxConstraints.tight(
                          Size.square(isVeryNarrow ? 36 : 40),
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap, this.compact = false});
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 2 : 6,
          vertical: compact ? 4 : 6,
        ),
        child: Row(
          children: [
            Container(
              width: compact ? 32 : 36,
              height: compact ? 32 : 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.mainColors.accent,
                    colors.mainColors.accentSecondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  AppStrings.brandShort,
                  style: context.textStyle.openSansStyles.extraBoldOpenSans16
                      .copyWith(color: colors.mainColors.onPrimary),
                ),
              ),
            ),
            const SizedBox(width: 12),
            if (!context.isMobile)
              Text(
                AppStrings.authorName,
                style: context.textStyle.openSansStyles.semiBoldOpenSans16
                    .copyWith(color: context.colors.textColors.primary),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: context.textStyle.openSansStyles.mediumOpenSans14.copyWith(
              color: _hover
                  ? colors.mainColors.accent
                  : colors.textColors.primary),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle({this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        final isDark = mode == ThemeMode.dark;
        return IconButton(
          constraints: BoxConstraints.tight(Size.square(compact ? 36 : 40)),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          tooltip: isDark ? 'Светлая тема' : 'Тёмная тема',
          onPressed: () => context.read<ThemeCubit>().toggle(),
          icon: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          ),
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// Mobile drawer
// -----------------------------------------------------------------------------

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.colors.mainColors.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text(AppStrings.navHome),
                onTap: () {
                  Navigator.of(context).pop();
                  GoRouter.of(context).go(AppRoutes.home);
                },
              ),
              ListTile(
                title: const Text(AppStrings.navProjects),
                onTap: () {
                  Navigator.of(context).pop();
                  GoRouter.of(context).go(AppRoutes.projects);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
