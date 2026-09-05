import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';

import 'dart:ui';

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
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 80.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: (isDark ? AppColors.surfaceDark : AppColors.bgLight).withValues(alpha: 0.75),
            border: Border(
              bottom: BorderSide(
                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08),
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
                          Image.asset(
                            'assets/images/header_logo.png',
                            height: 28,
                            fit: BoxFit.contain,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            errorBuilder: (context, error, stackTrace) {
                              return Text(
                                AppConfig.studioName,
                                style: AppTypography.heading2(
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                ).copyWith(letterSpacing: -0.5, fontWeight: FontWeight.bold),
                              );
                            },
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
                        const SizedBox(width: 36),
                        // "Start a Project" Button
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: AppColors.accentGradient,
                              boxShadow: AppColors.glowAccent,
                            ),
                            child: ElevatedButton(
                              onPressed: () => context.go('/start'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Start Project',
                                    style: AppTypography.buttonText(color: Colors.white),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white),
                                ],
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
