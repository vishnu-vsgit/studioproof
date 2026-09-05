import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/common/kinetic_marquee_widget.dart';
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

    return Title(
      title: 'StudioProof — Independent Graphic Design Studio',
      color: isDark ? AppColors.bgDark : AppColors.bgLight,
      child: PageScaffold(
        currentPath: '/',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HERO SECTION
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: isMobile
                    ? 0.0
                    : (MediaQuery.of(context).size.height - 140.0).clamp(
                        440.0,
                        750.0,
                      ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 28.0 : 48.0,
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
                                context,
                                isDark,
                                isMobile,
                                scale,
                              ),
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

            // 1.5 CLIENT TRUST & AVAILABILITY BANNER
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 18.0 : 20.0,
              ),
              color: isDark
                  ? AppColors.surfaceSubtleDark
                  : AppColors.surfaceSubtleLight,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: ResponsiveBreakpoints.maxContentWidth,
                  ),
                  child: isMobile
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF22C55E),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'ACCEPTING NEW COMMISSIONS & PARTNERSHIPS',
                                style:
                                    AppTypography.labelUppercase(
                                      color: isDark
                                          ? AppColors.textPrimaryDark
                                          : AppColors.textPrimaryLight,
                                      scale: scale,
                                    ).copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11 * scale,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                            ),
                          ],
                        )
                      : Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 24,
                          runSpacing: 12,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF22C55E),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'ACCEPTING NEW WORKS & RECURRING PARTNERSHIPS',
                                  style:
                                      AppTypography.labelUppercase(
                                        color: isDark
                                            ? AppColors.textPrimaryDark
                                            : AppColors.textPrimaryLight,
                                        scale: scale,
                                      ).copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11 * scale,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              'COMPLETED GRAPHIC DESIGN & TRAINING FOR: MULTIPLE CAMPUS COMMUNITIES & INDIVIDUALS',
                              style:
                                  AppTypography.labelUppercase(
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                    scale: scale,
                                  ).copyWith(
                                    fontSize: 10.5 * scale,
                                    letterSpacing: 1.2,
                                  ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            if (!isMobile) ...[
              // 1.8 KINETIC MARQUEE TYPOGRAPHY BANNER
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                color: isDark ? AppColors.bgDark : AppColors.bgLight,
                child: const KineticMarqueeWidget(
                  text:
                      'POSTER DESIGN • BRAND IDENTITY • CAMPAIGN KEY VISUALS • DESIGN TRAINING',
                  fontSize: 64,
                  opacity: 0.14,
                  speed: 40.0,
                ),
              ),
              Divider(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                height: 1,
              ),
            ],

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
                      const SizedBox(height: 12),
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
                      const SizedBox(height: 8),
                      Text(
                        'Clear, deliberate graphic design solutions and hands-on paid training sessions.',
                        style: AppTypography.bodyLarge(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // 4 Core Highlights (Responsive Layout: 1-col on mobile, 2x2 grid on tablet, 4-col on desktop)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          if (width < 640) {
                            return Column(
                              children: const [
                                _HighlightCard(
                                  number: '01',
                                  title: 'Posters & Campaigns',
                                  description:
                                      'High-impact key visuals, festival posters & digital promotional graphics.',
                                ),
                                SizedBox(height: 12),
                                _HighlightCard(
                                  number: '02',
                                  title: 'Brand Identity',
                                  description:
                                      'Clean visual identity systems, logos & typography guidelines.',
                                ),
                                SizedBox(height: 12),
                                _HighlightCard(
                                  number: '03',
                                  title: 'Design Training',
                                  description:
                                      'Paid Training sessions in Photoshop & Figma.',
                                ),
                                SizedBox(height: 12),
                                _HighlightCard(
                                  number: '04',
                                  title: 'Design Support',
                                  description:
                                      'Ongoing monthly design partnership for campus clubs, startups & creators.',
                                ),
                              ],
                            );
                          } else if (width < 1080) {
                            return Column(
                              children: const [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _HighlightCard(
                                        number: '01',
                                        title: 'Posters & Campaigns',
                                        description:
                                            'High-impact key visuals, festival posters, stage backdrops, and digital promotional graphics.',
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _HighlightCard(
                                        number: '02',
                                        title: 'Brand Identity',
                                        description:
                                            'Clean visual identity systems, typography guidelines, and logo assets tailored for startups & clubs.',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _HighlightCard(
                                        number: '03',
                                        title: 'Design Training',
                                        description:
                                            'Hands-on paid training sessions in Photoshop, Figma, poster design & visual layout principles.',
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _HighlightCard(
                                        number: '04',
                                        title: 'Design Support',
                                        description:
                                            'Ongoing monthly design partnership for campus clubs, startups, and creators needing regular visuals.',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Expanded(
                                  child: _HighlightCard(
                                    number: '01',
                                    title: 'Posters & Campaigns',
                                    description:
                                        'High-impact key visuals, festival posters, stage backdrops, and digital promotional graphics.',
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: _HighlightCard(
                                    number: '02',
                                    title: 'Brand Identity',
                                    description:
                                        'Clean visual identity systems, typography guidelines, and logo assets tailored for startups & clubs.',
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: _HighlightCard(
                                    number: '03',
                                    title: 'Design Training',
                                    description:
                                        'Hands-on paid training sessions in Photoshop, Figma, poster design & visual layout principles.',
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: _HighlightCard(
                                    number: '04',
                                    title: 'Design Support',
                                    description:
                                        'Ongoing monthly design partnership for campus clubs, startups, and creators needing regular visuals.',
                                  ),
                                ),
                              ],
                            );
                          }
                        },
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
                vertical: isMobile ? 32.0 : 72.0,
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
                      const SizedBox(height: 12),
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
                      const SizedBox(height: 8),
                      Text(
                        'A curated collection of poster designs, brand identities, and promotional campaigns.',
                        style: AppTypography.bodyLarge(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Horizontal Work Carousel featuring User's Actual Design Works
                      WorkCarouselWidget(projects: allProjects),
                    ],
                  ),
                ),
              ),
            ),

            if (!isMobile) ...[
              // 3.5 REVERSE KINETIC MARQUEE TYPOGRAPHY BANNER
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                child: const KineticMarqueeWidget(
                  text:
                      'HIGH-IMPACT VISUAL DIRECTION • CREATIVE MOMENTUM • PURPOSE BUILT DESIGN',
                  reverse: true,
                  fontSize: 56,
                  opacity: 0.12,
                  speed: 45.0,
                ),
              ),
              Divider(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                height: 1,
              ),
            ],

            // 4. STUDIO STATEMENT SECTION
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 32.0 : 72.0,
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
                      const SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 960),
                        child: Text(
                          'From standalone event posters to ongoing design support, I work with people and teams who need their ideas to look as good as they sound.',
                          style: isMobile
                              ? AppTypography.heading2(
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

            // 5. PROCESS SECTION (Vertical Steps on Mobile, Horizontal Row on Desktop)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 32.0 : 72.0,
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
                      const SizedBox(height: 12),
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
                      const SizedBox(height: 24),

                      if (isMobile)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            _ProcessStepItem(
                              number: '01',
                              title: 'Tell us what you need',
                              body:
                                  'Share goals, deadline & context through quick enquiry form.',
                            ),
                            SizedBox(height: 24),
                            _ProcessStepItem(
                              number: '02',
                              title: 'We design',
                              body:
                                  'We develop visual concepts in Figma & Photoshop.',
                            ),
                            SizedBox(height: 24),
                            _ProcessStepItem(
                              number: '03',
                              title: 'You receive final files',
                              body:
                                  'Get print PDFs, high-res PNGs & source files.',
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
                vertical: isMobile ? 32.0 : 72.0,
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
                            const SizedBox(height: 8),
                            Text(
                              'Whether it’s a single event poster or ongoing monthly design support, let’s talk.',
                              style: AppTypography.bodyLarge(
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => context.go('/start'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                elevation: 0,
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
                              onPressed: () => context.go('/start'),
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
      ),
    );
  }

  Widget _buildHeroLeftText(
    BuildContext context,
    bool isDark,
    bool isMobile,
    double scale,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Studio Tagline Badge
        Text(
          AppConfig.studioTagline.toUpperCase(),
          style: AppTypography.labelUppercase(
            color: isDark
                ? AppColors.textMutedDark
                : AppColors.textMutedLight,
            scale: scale,
          ),
        ),
        SizedBox(height: isMobile ? 16 : 24),

        // Display Headline
        Text(
          'Visual design that commands attention.',
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
        SizedBox(height: isMobile ? 12 : 24),

        // Supporting Copy
        Text(
          'High-impact posters, campaign key visuals, brand identity, and paid training sessions for campus events, startups, creators & aspiring designers.',
          style: AppTypography.bodyLarge(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            scale: scale,
          ),
        ),
        SizedBox(height: isMobile ? 24 : 36),

        // Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: AppColors.accentGradient,
                boxShadow: AppColors.glowAccent,
              ),
              child: ElevatedButton(
                onPressed: () => context.go('/start'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 36,
                    vertical: isMobile ? 16 : 22,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Start a Project',
                      style: AppTypography.buttonText(color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            if (isMobile)
              OutlinedButton(
                onPressed: () => context.go('/services'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  side: BorderSide(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  'Services',
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
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
                      'STUDIO SPECSHEET',
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
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
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
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 180),
      padding: EdgeInsets.all(isMobile ? 18.0 : 22.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.bgDark : AppColors.bgLight,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: AppTypography.labelUppercase(color: AppColors.accent),
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
            description,
            style: AppTypography.bodySmall(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ).copyWith(height: 1.35),
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
