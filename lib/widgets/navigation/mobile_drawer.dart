import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class MobileDrawer extends StatelessWidget {
  final String currentPath;

  const MobileDrawer({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      elevation: 0,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header in Drawer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/header_logo.png',
                    height: 26,
                    fit: BoxFit.contain,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                    errorBuilder: (context, error, stackTrace) => Text(
                      AppConfig.studioName,
                      style: AppTypography.heading2(
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 28,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                height: 1,
              ),
              const SizedBox(height: 24),

              // Drawer Links
              _MobileNavItem(
                number: '00',
                label: 'Home',
                subtitle: 'Overview & recent design portfolio',
                isActive: currentPath == '/',
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/');
                },
              ),
              const SizedBox(height: 12),
              _MobileNavItem(
                number: '01',
                label: 'Services',
                subtitle: 'Single poster & recurring design support',
                isActive: currentPath == '/services',
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/services');
                },
              ),
              const SizedBox(height: 12),
              _MobileNavItem(
                number: '02',
                label: 'About',
                subtitle: 'Designer bio & core stack',
                isActive: currentPath == '/about',
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/about');
                },
              ),
              const SizedBox(height: 12),
              _MobileNavItem(
                number: '03',
                label: 'Contact',
                subtitle: 'Direct email & instant channels',
                isActive: currentPath == '/contact',
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/contact');
                },
              ),
              const Spacer(),

              // Quick Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go('/start-a-project');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'Start a project →',
                    style: AppTypography.buttonText(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  AppConfig.contactEmail,
                  style: AppTypography.bodySmall(
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String number;
  final String label;
  final String subtitle;
  final bool isActive;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.number,
    required this.label,
    required this.subtitle,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: isActive
                ? (isDark ? AppColors.surfaceDark : AppColors.surfaceLight)
                : Colors.transparent,
            border: Border.all(
              color: isActive
                  ? AppColors.accent
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        number,
                        style: AppTypography.labelUppercase(
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        label,
                        style: AppTypography.heading2(
                          color: isActive
                              ? AppColors.accent
                              : (isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: isActive
                        ? AppColors.accent
                        : (isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  subtitle,
                  style: AppTypography.bodySmall(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
