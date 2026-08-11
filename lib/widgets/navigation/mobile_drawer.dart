import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class MobileDrawer extends StatelessWidget {
  final String currentPath;

  const MobileDrawer({
    super.key,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      elevation: 0,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header in Drawer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppConfig.studioName,
                    style: AppTypography.heading2(
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 32,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 40),

              // Drawer Links
              _MobileNavItem(
                label: 'Services',
                subtitle: 'One-off & recurring design support',
                isActive: currentPath == '/services',
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/services');
                },
              ),
              const SizedBox(height: 32),
              _MobileNavItem(
                label: 'About',
                subtitle: 'Designer bio & tools',
                isActive: currentPath == '/about',
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/about');
                },
              ),
              const SizedBox(height: 32),
              _MobileNavItem(
                label: 'Contact',
                subtitle: 'Project enquiry & details',
                isActive: currentPath == '/contact',
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/contact');
                },
              ),
              const Spacer(),

              // Mobile "Start a project" CTA
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go('/contact');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool isActive;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.label,
    required this.subtitle,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: AppTypography.displaySmall(
                  color: isActive ? AppColors.accent : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                ),
              ),
              if (isActive) ...[
                const SizedBox(width: 12),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySmall(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
