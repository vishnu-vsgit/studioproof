import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../widgets/layout/page_scaffold.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return Title(
      title: '404 — Page Not Found | StudioProof',
      color: isDark ? AppColors.bgDark : AppColors.bgLight,
      child: PageScaffold(
        currentPath: '/404',
        body: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 80.0 : 120.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '404 ERROR',
                  style: AppTypography.labelUppercase(
                    color: AppColors.accent,
                    scale: scale,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: isMobile
                      ? AppTypography.heading1(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        )
                      : AppTypography.displayLarge(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: Text(
                    'The page you are looking for might have been removed, renamed, or is temporarily unavailable.',
                    style: AppTypography.bodyLarge(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      scale: scale,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go('/'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                        foregroundColor: isDark
                            ? AppColors.bgDark
                            : AppColors.bgLight,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 18,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Back to Home',
                        style: AppTypography.buttonText(
                          color: isDark
                              ? AppColors.bgDark
                              : AppColors.bgLight,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => context.go('/contact'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                        side: BorderSide(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 18,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Contact Support',
                        style: AppTypography.buttonText(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
