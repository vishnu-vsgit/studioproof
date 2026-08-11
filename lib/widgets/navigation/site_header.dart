import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';

class SiteHeader extends StatelessWidget {
  final String currentPath;
  final VoidCallback onOpenMobileMenu;

  const SiteHeader({
    super.key,
    required this.currentPath,
    required this.onOpenMobileMenu,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);

    return Container(
      height: 80.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: (isDark ? AppColors.bgDark : AppColors.bgLight).withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Studio Name / Logo
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.go('/'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppConfig.studioName,
                        style: AppTypography.heading2(
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ).copyWith(letterSpacing: 1.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              // Desktop Navigation Links & CTA
              if (!isMobile)
                Row(
                  children: [
                    _NavLink(
                      label: 'Services',
                      path: '/services',
                      isActive: currentPath == '/services',
                      onTap: () => context.go('/services'),
                    ),
                    const SizedBox(width: 36),
                    _NavLink(
                      label: 'About',
                      path: '/about',
                      isActive: currentPath == '/about',
                      onTap: () => context.go('/about'),
                    ),
                    const SizedBox(width: 36),
                    _NavLink(
                      label: 'Contact',
                      path: '/contact',
                      isActive: currentPath == '/contact',
                      onTap: () => context.go('/contact'),
                    ),
                    const SizedBox(width: 40),
                    // "Start a Project" Button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: OutlinedButton(
                        onPressed: () => context.go('/contact'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          side: BorderSide(
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            width: 1.5,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        ),
                        child: Text(
                          'Start a project',
                          style: AppTypography.buttonText(
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                // Mobile Hamburger Menu Button
                IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    size: 28,
                  ),
                  onPressed: onOpenMobileMenu,
                  tooltip: 'Open menu',
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final String path;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.path,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: AppTypography.buttonText(
                color: widget.isActive || _isHovered
                    ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight)
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              ).copyWith(
                fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: widget.isActive || _isHovered ? 24 : 0,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}
