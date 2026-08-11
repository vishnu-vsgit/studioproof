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
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
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
          // 1. HERO SECTION (2-column split on desktop to balance right-side space)
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: isMobile
                  ? 0.0
                  : (MediaQuery.of(context).size.height - 140.0)
                      .clamp(440.0, 750.0),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 36.0 : 48.0,
            ),
            alignment: Alignment.centerLeft,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.maxContentWidth,
                ),
                child: isMobile
                    ? _buildHeroLeftText(context, isDark, isMobile, scale)
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: _buildHeroLeftText(
                                context, isDark, isMobile, scale),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            flex: 5,
                            child: _HeroStudioBadgeCard(isDark: isDark),
                          ),
                        ],
                      ),
              ),
            ),
          ),

          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            height: 1,
          ),

          // 2. CONTENT BETWEEN HERO & RECENT DESIGNS: CORE HIGHLIGHTS SECTION
          Container(
            width: double.infinity,
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 40.0 : 64.0,
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
                      'WHAT WE DO',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Purpose-built visual communication',
                      style: isMobile
                          ? AppTypography.heading1(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displayMedium(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Clear, deliberate graphic design solutions for organizations and creators.',
                      style: AppTypography.bodyLarge(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // 4 Core Highlights Cards
                    if (isMobile)
                      Column(
                        children: const [
                          _HighlightCard(
                            number: '01',
                            title: 'Posters & Campaigns',
                            description:
                                'High-impact key visuals, festival posters, stage backdrops, and digital promotional graphics.',
                          ),
                          SizedBox(height: 16),
                          _HighlightCard(
                            number: '02',
                            title: 'Brand Identity',
                            description:
                                'Clean visual identity systems, typography guidelines, and logo assets tailored for startups & clubs.',
                          ),
                          SizedBox(height: 16),
                          _HighlightCard(
                            number: '03',
                            title: 'Fast Turnarounds',
                            description:
                                'Efficient turnaround times with complete production-ready print PDFs and digital PNG packages.',
                          ),
                          SizedBox(height: 16),
                          _HighlightCard(
                            number: '04',
                            title: 'No Generic Templates',
                            description:
                                'Distinct visual execution focused on clarity, typographic structure, and custom visual direction.',
                          ),
                        ],
                      )
                    else
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Expanded(
                              child: _HighlightCard(
                                number: '01',
                                title: 'Posters & Campaigns',
                                description:
                                    'High-impact key visuals, festival posters, stage backdrops, and digital promotional graphics.',
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _HighlightCard(
                                number: '02',
                                title: 'Brand Identity',
                                description:
                                    'Clean visual identity systems, typography guidelines, and logo assets tailored for startups & clubs.',
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _HighlightCard(
                                number: '03',
                                title: 'Fast Turnarounds',
                                description:
                                    'Efficient turnaround times with complete production-ready print PDFs and digital PNG packages.',
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _HighlightCard(
                                number: '04',
                                title: 'No Generic Templates',
                                description:
                                    'Distinct visual execution focused on clarity, typographic structure, and custom visual direction.',
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            height: 1,
          ),

          // 3. DEDICATED RECENT DESIGN WORKS SECTION
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
                      'SELECTED PORTFOLIO',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Recent Design Works',
                      style: isMobile
                          ? AppTypography.heading1(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displayMedium(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'A curated collection of poster designs, brand identities, and promotional campaigns.',
                      style: AppTypography.bodyLarge(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Horizontal Work Carousel featuring User's Actual Design Works
                    WorkCarouselWidget(projects: allProjects),
                  ],
                ),
              ),
            ),
          ),

          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            height: 1,
          ),

          // 4. STUDIO STATEMENT SECTION
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

          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            height: 1,
          ),

          // 5. PROCESS SECTION
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

          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            height: 1,
          ),

          // 6. CALL-TO-ACTION BANNER
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
                            onPressed: () => context.go('/start-a-project'),
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
                            onPressed: () => context.go('/start-a-project'),
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

  Widget _buildHeroLeftText(
      BuildContext context, bool isDark, bool isMobile, double scale) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
                color:
                    isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                scale: scale,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Display Headline
        Text(
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
        const SizedBox(height: 24),

        // Supporting Copy
        Text(
          'Designing posters, campaigns and visual identities for colleges, startups, businesses and people with something worth saying.',
          style: AppTypography.bodyLarge(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            scale: scale,
          ),
        ),
        const SizedBox(height: 36),

        // Action Button ("Start a project")
        ElevatedButton(
          onPressed: () => context.go('/start-a-project'),
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
      ],
    );
  }
}

class _HeroStudioBadgeCard extends StatelessWidget {
  final bool isDark;

  const _HeroStudioBadgeCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Monogram & Status Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/sp_transparent.png',
                height: 38,
                fit: BoxFit.contain,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                errorBuilder: (context, error, stackTrace) => Text(
                  'SP',
                  style: AppTypography.displayMedium(color: AppColors.accent),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  border: Border.all(color: AppColors.accent),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'STUDIO SPEC SHEET',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Studio Artboard Details
          _BadgeStatRow(
            label: 'CORE SERVICES',
            value: 'Graphic & Campaign Design',
            isDark: isDark,
          ),
          const SizedBox(height: 14),
          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            height: 1,
          ),
          const SizedBox(height: 14),
          _BadgeStatRow(
            label: 'PRIMARY STACK',
            value: 'Figma • Adobe Photoshop',
            isDark: isDark,
          ),
          const SizedBox(height: 14),
          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            height: 1,
          ),
          const SizedBox(height: 14),
          _BadgeStatRow(
            label: 'DELIVERABLES',
            value: 'Print PDFs • Digital PNGs • Sources',
            isDark: isDark,
          ),
          const SizedBox(height: 14),
          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            height: 1,
          ),
          const SizedBox(height: 14),
          _BadgeStatRow(
            label: 'LOCATION',
            value: 'India • Remote Worldwide',
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _BadgeStatRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _BadgeStatRow({
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelUppercase(
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.bodyMedium(
            color:
                isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
      ],
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _HighlightCard({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDark : AppColors.bgLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: AppTypography.labelUppercase(color: AppColors.accent),
          ),
          const SizedBox(height: 16),
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
            description,
            style: AppTypography.bodyMedium(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
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
