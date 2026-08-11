import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/layout/page_scaffold.dart';
import '../../widgets/portfolio/work_carousel_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(
      context,
    );
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    final allProjects = PortfolioData.projects;

    return PageScaffold(
      currentPath: '/',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. HERO SECTION
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: isMobile ? 36.0 : 64.0,
              bottom: isMobile ? 40.0 : 64.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.maxContentWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Studio Tagline Badge
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppConfig.studioTagline.toUpperCase(),
                          style: AppTypography.labelUppercase(
                            color: isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMutedLight,
                            scale: scale,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Display Headline
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 960),
                      child: Text(
                        'Good ideas deserve better visuals.',
                        style: isMobile
                            ? AppTypography.displaySmall(
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                                scale: scale,
                              )
                            : AppTypography.displayLarge(
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                                scale: scale,
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Supporting Copy
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Text(
                        'Designing posters, campaigns and visual identities for colleges, startups, businesses and people with something worth saying.',
                        style: AppTypography.bodyLarge(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                          scale: scale,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Action Button (Only "Start a project")
                    ElevatedButton(
                      onPressed: () => context.go('/contact'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 28 : 36,
                          vertical: isMobile ? 18 : 22,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Start a project →',
                        style: AppTypography.buttonText(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 56),

                    // Horizontal Work Carousel featuring User's Actual Design Works
                    WorkCarouselWidget(projects: allProjects),
                  ],
                ),
              ),
            ),
          ),

          const Divider(),

          // 2. STUDIO STATEMENT SECTION
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 48.0 : 72.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.maxContentWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STUDIO STATEMENT',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 960),
                      child: Text(
                        'From one-off posters to ongoing design support, I work with people and teams who need their ideas to look as good as they sound.',
                        style: isMobile
                            ? AppTypography.heading1(
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                                scale: scale,
                              )
                            : AppTypography.displayMedium(
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                                scale: scale,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Divider(),

          // 3. PROCESS SECTION
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 48.0 : 72.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.maxContentWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PROCESS',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'How we work together',
                      style: isMobile
                          ? AppTypography.heading1(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displaySmall(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                    ),
                    const SizedBox(height: 40),

                    if (isMobile)
                      Column(
                        children: const [
                          _ProcessStepItem(
                            number: '01',
                            title: 'Tell us what you need',
                            body:
                                'Share your goals, deadline, assets and context through a short enquiry form or email.',
                          ),
                          SizedBox(height: 28),
                          _ProcessStepItem(
                            number: '02',
                            title: 'We design',
                            body:
                                'We develop clear visual concepts, refine details in Figma & Photoshop, and iterate until sharp.',
                          ),
                          SizedBox(height: 28),
                          _ProcessStepItem(
                            number: '03',
                            title: 'You receive final files',
                            body:
                                'Get production-ready print PDFs, high-res digital PNGs, source files and social sizes.',
                          ),
                        ],
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            child: _ProcessStepItem(
                              number: '01',
                              title: 'Tell us what you need',
                              body:
                                  'Share your goals, deadline, assets and context through a short enquiry form or email.',
                            ),
                          ),
                          SizedBox(width: 40),
                          Expanded(
                            child: _ProcessStepItem(
                              number: '02',
                              title: 'We design',
                              body:
                                  'We develop clear visual concepts, refine details in Figma & Photoshop, and iterate until sharp.',
                            ),
                          ),
                          SizedBox(width: 40),
                          Expanded(
                            child: _ProcessStepItem(
                              number: '03',
                              title: 'You receive final files',
                              body:
                                  'Get production-ready print PDFs, high-res digital PNGs, source files and social sizes.',
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),

          const Divider(),

          // 4. CALL-TO-ACTION BANNER
          Container(
            width: double.infinity,
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 48.0 : 72.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.maxContentWidth,
                ),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ready to start your project?',
                            style: AppTypography.heading1(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Whether it’s a single event poster or ongoing monthly design support, let’s talk.',
                            style: AppTypography.bodyLarge(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => context.go('/contact'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 18,
                              ),
                            ),
                            child: Text(
                              'Start a project →',
                              style: AppTypography.buttonText(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ready to start your project?',
                                  style: AppTypography.displayMedium(
                                    color: isDark
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Whether it’s a single event poster or ongoing monthly design support, let’s talk.',
                                  style: AppTypography.bodyLarge(
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 48),
                          ElevatedButton(
                            onPressed: () => context.go('/contact'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36,
                                vertical: 22,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              'Start a project →',
                              style: AppTypography.buttonText(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessStepItem extends StatelessWidget {
  final String number;
  final String title;
  final String body;

  const _ProcessStepItem({
    required this.number,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: AppTypography.displayMedium(color: AppColors.accent),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: AppTypography.heading3(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: AppTypography.bodyMedium(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}
