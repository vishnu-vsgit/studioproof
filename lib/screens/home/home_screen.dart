import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/common/kinetic_marquee_widget.dart';
import '../../widgets/layout/page_scaffold.dart';
import '../../widgets/portfolio/work_carousel_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Active state for single expanded FAQ item (null if all closed)
  int? _expandedFaqIndex = 0;

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);
    final allProjects = PortfolioData.projects;

    return Title(
      title: 'StudioProof — Independent Graphic Design Studio',
      color: AppColors.bgLight,
      child: PageScaffold(
        currentPath: '/',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. HERO SECTION
            // End Result + Fear Elimination + Supporting Visual
            // ==========================================
            _ScrollEntranceAnimation(
              staggerIndex: 0,
              child: Container(
                width: double.infinity,
                color: AppColors.bgLight,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile ? 36.0 : 64.0,
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
                              _buildHeroLeftText(context, scale, isMobile),
                              const SizedBox(height: 36),
                              const _HeroVisualCard(),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: _buildHeroLeftText(context, scale, isMobile),
                              ),
                              const SizedBox(width: 48),
                              const Expanded(
                                flex: 5,
                                child: _HeroVisualCard(),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // 1.5 AVAILABILITY & TRUST BANNER
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 18.0 : 20.0,
              ),
              color: AppColors.surfaceLight,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: ResponsiveBreakpoints.maxContentWidth,
                  ),
                  child: isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.statusAvailable,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'ACCEPTING NEW COMMISSIONS & PROJECTS',
                                  style: AppTypography.labelUppercase(
                                    color: AppColors.textPrimaryLight,
                                    scale: scale,
                                  ).copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11 * scale,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'POSTERS • CAMPAIGNS • STARTUPS • CAMPUS EVENTS • DESIGN TRAINING',
                              style: AppTypography.labelUppercase(
                                color: AppColors.textSecondaryLight,
                                scale: scale,
                              ).copyWith(fontSize: 9.5 * scale),
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
                                    color: AppColors.statusAvailable,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'ACCEPTING NEW COMMISSIONS & WORKSHOPS',
                                  style: AppTypography.labelUppercase(
                                    color: AppColors.textPrimaryLight,
                                    scale: scale,
                                  ).copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11 * scale,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'POSTER DESIGN • CAMPAIGN VISUALS • CAMPUS EVENTS • FIGMA & PHOTOSHOP',
                              style: AppTypography.labelUppercase(
                                color: AppColors.textSecondaryLight,
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
              // KINETIC MARQUEE TYPOGRAPHY
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                color: AppColors.bgLight,
                child: const KineticMarqueeWidget(
                  text: 'POSTER DESIGN • BRAND IDENTITY • CAMPAIGN KEY VISUALS • DESIGN TRAINING',
                  fontSize: 56,
                  opacity: 0.12,
                  speed: 40.0,
                ),
              ),
              const Divider(color: AppColors.borderLight, height: 1),
            ],

            // ==========================================
            // 2. PROBLEM SECTION (CLEAN COMPARISON MATRIX)
            // ==========================================
            _ScrollEntranceAnimation(
              staggerIndex: 1,
              child: Container(
                width: double.infinity,
                color: AppColors.bgLight,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile ? 48.0 : 80.0,
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
                          'VISUAL DIRECTION COMPARISON',
                          style: AppTypography.labelUppercase(
                            color: AppColors.textPrimaryLight,
                            scale: scale,
                          ).copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Why Clear Visual Direction Matters.',
                          style: AppTypography.heading1(
                            color: AppColors.textPrimaryLight,
                            scale: scale,
                          ).copyWith(fontSize: (isMobile ? 28 : 40) * scale, height: 1.15),
                        ),
                        const SizedBox(height: 36),
                        // Comparison Matrix Box
                        const _LastMinuteVsStudioProofComparison(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ==========================================
            // 3. SOLUTION / VALUE SECTION
            // 5 Features & Benefits
            // ==========================================
            _ScrollEntranceAnimation(
              staggerIndex: 2,
              child: Container(
                width: double.infinity,
                color: AppColors.surfaceLight,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile ? 48.0 : 80.0,
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
                          'SERVICES & VALUE',
                          style: AppTypography.labelUppercase(
                            color: AppColors.textPrimaryLight,
                            scale: scale,
                          ).copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Clear Visual Direction Built For Real Impact.',
                          style: AppTypography.heading1(
                            color: AppColors.textPrimaryLight,
                            scale: scale,
                          ).copyWith(fontSize: (isMobile ? 28 : 40) * scale, height: 1.15),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'StudioProof brings structure, sharp typography, and bold visual hierarchy to posters, social campaigns, and design workshops.',
                          style: AppTypography.bodyLarge(
                            color: AppColors.textSecondaryLight,
                            scale: scale,
                          ),
                        ),
                        const SizedBox(height: 48),

                        // 3 Clean Feature Cards
                        Column(
                          children: const [
                            _FeatureValueCard(
                              title: 'Poster & Campaign Key Visuals',
                              description:
                                  'High-contrast event posters, fest announcements, and keynote speaker reveal graphics designed in Figma & Photoshop.',
                              icon: Icons.campaign_rounded,
                            ),
                            SizedBox(height: 20),
                            _FeatureValueCard(
                              title: 'Startup & Business Visual Identity',
                              description:
                                  'Clean logo marks, visual systems, and brand assets tailored for tech startups, small businesses, and creators.',
                              icon: Icons.business_center_rounded,
                            ),
                            SizedBox(height: 20),
                            _FeatureValueCard(
                              title: 'Design Training & Workshops',
                              description:
                                  'Hands-on practical graphic design training sessions covering Figma, Photoshop fundamentals, poster layout, and visual hierarchy.',
                              icon: Icons.school_rounded,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // PORTFOLIO CAROUSEL PREVIEW
            _ScrollEntranceAnimation(
              staggerIndex: 3,
              child: Container(
                color: AppColors.bgLight,
                padding: EdgeInsets.symmetric(vertical: isMobile ? 36.0 : 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: ResponsiveBreakpoints.maxContentWidth,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'FEATURED DESIGN WORK',
                                textAlign: TextAlign.center,
                                style: AppTypography.labelUppercase(
                                  color: AppColors.textPrimaryLight,
                                  scale: scale,
                                ).copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Selected Poster & Event Showcase',
                                textAlign: TextAlign.center,
                                style: AppTypography.heading2(
                                  color: AppColors.textPrimaryLight,
                                  scale: scale,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    WorkCarouselWidget(projects: allProjects),
                  ],
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ==========================================
            // 4. HOW IT WORKS SECTION
            // 4 Clear Steps
            // ==========================================
            _ScrollEntranceAnimation(
              staggerIndex: 4,
              child: Container(
                width: double.infinity,
                color: AppColors.bgLight,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile ? 48.0 : 80.0,
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
                          'THE PROCESS',
                          style: AppTypography.labelUppercase(
                            color: AppColors.textPrimaryLight,
                            scale: scale,
                          ).copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Four Simple Steps To Project Delivery.',
                          style: AppTypography.heading1(
                            color: AppColors.textPrimaryLight,
                            scale: scale,
                          ).copyWith(fontSize: (isMobile ? 28 : 40) * scale, height: 1.15),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Getting started is quick and straightforward. No unnecessary paperwork or complicated procedures.',
                          style: AppTypography.bodyLarge(
                            color: AppColors.textSecondaryLight,
                            scale: scale,
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Step Grid - Equal Height & Perfectly Aligned Across All Screen Sizes
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;

                            // 1. Desktop & Large Monitors (1024px+): 4 equal-size cards side by side
                            if (width >= 1024) {
                              return IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: const [
                                    Expanded(
                                      child: _StepCard(
                                        stepNumber: '01',
                                        title: 'Share Brief & Content',
                                        description:
                                            'Fill out our quick project form or send event details, text content, and logo assets via WhatsApp/Email.',
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _StepCard(
                                        stepNumber: '02',
                                        title: 'Concept Creation',
                                        description:
                                            'Visual concepts and layout directions are crafted in Figma and Photoshop with strong typographic hierarchy.',
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _StepCard(
                                        stepNumber: '03',
                                        title: 'Review & Refine',
                                        description:
                                            'Review high-res drafts, suggest layout adjustments, and finalize text and color details together.',
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _StepCard(
                                        stepNumber: '04',
                                        title: 'Delivery & Launch',
                                        description:
                                            'Receive print-ready PDFs and digital PNG/JPG assets formatted for social media and event screens.',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            // 2. Tablet & Medium Screens (640px to 1023px): 2x2 grid with equal height per row
                            if (width >= 640) {
                              return Column(
                                children: const [
                                  IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: _StepCard(
                                            stepNumber: '01',
                                            title: 'Share Brief & Content',
                                            description:
                                                'Fill out our quick project form or send event details, text content, and logo assets via WhatsApp/Email.',
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: _StepCard(
                                            stepNumber: '02',
                                            title: 'Concept Creation',
                                            description:
                                                'Visual concepts and layout directions are crafted in Figma and Photoshop with strong typographic hierarchy.',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: _StepCard(
                                            stepNumber: '03',
                                            title: 'Review & Refine',
                                            description:
                                                'Review high-res drafts, suggest layout adjustments, and finalize text and color details together.',
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: _StepCard(
                                            stepNumber: '04',
                                            title: 'Delivery & Launch',
                                            description:
                                                'Receive print-ready PDFs and digital PNG/JPG assets formatted for social media and event screens.',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }

                            // 3. Mobile Screens (< 640px): 1 column stacked layout
                            return Column(
                              children: const [
                                _StepCard(
                                  stepNumber: '01',
                                  title: 'Share Brief & Content',
                                  description:
                                      'Fill out our quick project form or send event details, text content, and logo assets via WhatsApp/Email.',
                                ),
                                SizedBox(height: 16),
                                _StepCard(
                                  stepNumber: '02',
                                  title: 'Concept Creation',
                                  description:
                                      'Visual concepts and layout directions are crafted in Figma and Photoshop with strong typographic hierarchy.',
                                ),
                                SizedBox(height: 16),
                                _StepCard(
                                  stepNumber: '03',
                                  title: 'Review & Refine',
                                  description:
                                      'Review high-res drafts, suggest layout adjustments, and finalize text and color details together.',
                                ),
                                SizedBox(height: 16),
                                _StepCard(
                                  stepNumber: '04',
                                  title: 'Delivery & Launch',
                                  description:
                                      'Receive print-ready PDFs and digital PNG/JPG assets formatted for social media and event screens.',
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ==========================================
            // 5. FAQ SECTION
            // Expandable Accordions (Single Selection)
            // ==========================================
            _ScrollEntranceAnimation(
              staggerIndex: 5,
              child: Container(
                width: double.infinity,
                color: AppColors.surfaceLight,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile ? 48.0 : 80.0,
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
                          'FREQUENTLY ASKED QUESTIONS',
                          style: AppTypography.labelUppercase(
                            color: AppColors.textPrimaryLight,
                            scale: scale,
                          ).copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Everything You Need To Know Before Starting.',
                          style: AppTypography.heading1(
                            color: AppColors.textPrimaryLight,
                            scale: scale,
                          ).copyWith(fontSize: (isMobile ? 28 : 40) * scale, height: 1.15),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Here are clear answers regarding project types, design tools, turnaround times, and training workshops.',
                          style: AppTypography.bodyLarge(
                            color: AppColors.textSecondaryLight,
                            scale: scale,
                          ),
                        ),
                        const SizedBox(height: 48),

                        // FAQ Accordion List
                        _buildFaqItem(
                          index: 0,
                          question: 'What kind of design projects do you specialize in?',
                          answer:
                              'We focus on poster design, event campaign graphics, social media promotional sets, startup visual branding, and hands-on graphic design training workshops.',
                        ),
                        _buildFaqItem(
                          index: 1,
                          question: 'What software tools are used for designing?',
                          answer:
                              'All work is produced using Figma and Adobe Photoshop to ensure accurate typography scaling, crisp layout alignment, and high-resolution exports.',
                        ),
                        _buildFaqItem(
                          index: 2,
                          question: 'What is the typical turnaround time for a poster project?',
                          answer:
                              'Standard event posters and social media sets are delivered within 48 to 72 hours. Rush requests for urgent announcements can also be accommodated.',
                        ),
                        _buildFaqItem(
                          index: 3,
                          question: 'How do I share project details and request a quote?',
                          answer:
                              'You can submit details through our "Start Project" form or reach out directly on WhatsApp (+91 87789 44493) or Email (studioproof.ds@gmail.com).',
                        ),
                        _buildFaqItem(
                          index: 4,
                          question: 'Do you offer design workshops for college clubs & students?',
                          answer:
                              'Yes! We conduct practical design training sessions for campus organizations, student clubs, and individuals eager to learn Figma and Photoshop poster design.',
                        ),
                        _buildFaqItem(
                          index: 5,
                          question: 'What file formats will I receive upon project completion?',
                          answer:
                              'You will receive high-resolution PNG/JPG files optimized for social media feeds and digital screens, along with print-ready CMYK PDF files.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ==========================================
            // 6. FINAL CTA SECTION
            // Clear CTAs & Direct Contact Details
            // ==========================================
            _ScrollEntranceAnimation(
              staggerIndex: 6,
              child: Container(
                width: double.infinity,
                color: AppColors.bgLight,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile ? 56.0 : 96.0,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: ResponsiveBreakpoints.maxContentWidth,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(isMobile ? 32.0 : 64.0),
                      decoration: BoxDecoration(
                        color: AppColors.bgLight,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.textPrimaryLight, width: 2.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 32,
                            spreadRadius: -4,
                            offset: Offset(0, 16),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'START YOUR PROJECT',
                            style: AppTypography.labelUppercase(
                              color: AppColors.textPrimaryLight,
                              scale: scale,
                            ).copyWith(fontWeight: FontWeight.w800, fontSize: 12 * scale),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Give Your Next Event Or Brand Clear Visual Direction.',
                            textAlign: TextAlign.center,
                            style: AppTypography.displayMedium(
                              color: AppColors.textPrimaryLight,
                              scale: scale,
                            ).copyWith(
                              fontSize: (isMobile ? 32 : 48) * scale,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: Text(
                              'Whether you need an event poster, social campaign collateral, or a design workshop for your team, we are ready to collaborate.',
                              textAlign: TextAlign.center,
                              style: AppTypography.bodyLarge(
                                color: AppColors.textSecondaryLight,
                                scale: scale,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Action Buttons
                          isMobile
                              ? Column(
                                  children: [
                                    _buildPrimaryCtaButton(context, scale, isMobile: true),
                                    const SizedBox(height: 16),
                                    _buildWhatsAppButton(scale, isMobile: true),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildPrimaryCtaButton(context, scale, isMobile: false),
                                    const SizedBox(width: 20),
                                    _buildWhatsAppButton(scale, isMobile: false),
                                  ],
                                ),

                          const SizedBox(height: 36),

                          // Direct Contact Details Pill
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSubtleLight,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColors.borderLight),
                            ),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 16,
                              runSpacing: 8,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.email_outlined, size: 16, color: AppColors.textPrimaryLight),
                                    const SizedBox(width: 6),
                                    Text(
                                      AppConfig.contactEmail,
                                      style: AppTypography.bodySmall(color: AppColors.textPrimaryLight).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.phone_outlined, size: 16, color: AppColors.textPrimaryLight),
                                    const SizedBox(width: 6),
                                    Text(
                                      AppConfig.phoneNumber,
                                      style: AppTypography.bodySmall(color: AppColors.textPrimaryLight).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.camera_alt_outlined, size: 16, color: AppColors.textPrimaryLight),
                                    const SizedBox(width: 6),
                                    Text(
                                      AppConfig.instagramHandle,
                                      style: AppTypography.bodySmall(color: AppColors.textPrimaryLight).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hero Text Builder
  Widget _buildHeroLeftText(BuildContext context, double scale, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Clean Header Label
        RichText(
          text: TextSpan(
            style: AppTypography.labelUppercase(
              color: AppColors.textPrimaryLight,
              scale: scale,
            ).copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 11 * scale,
              letterSpacing: 1.5,
            ),
            children: const [
              TextSpan(text: 'STUDIO PROOF '),
              TextSpan(
                text: '• ',
                style: TextStyle(
                  color: Color(0xFFD94A26),
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(text: 'GRAPHIC DESIGN STUDIO'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Design That Captures Attention.',
          style: AppTypography.heading1(
            color: AppColors.textPrimaryLight,
            scale: scale,
          ).copyWith(
            fontSize: (isMobile ? 34 : 52) * scale,
            height: 1.1,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Built for real impact.',
          style: AppTypography.heading2(
            color: AppColors.textPrimaryLight,
            scale: scale,
          ).copyWith(
            fontSize: (isMobile ? 22 : 30) * scale,
            height: 1.25,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Independent graphic design studio crafting high-impact posters, campaign key visuals, and hands-on design training for campus events, startups, and creators.',
          style: AppTypography.bodyLarge(
            color: AppColors.textSecondaryLight,
            scale: scale,
          ).copyWith(
            fontSize: (isMobile ? 15 : 17) * scale,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton(
                onPressed: () => context.go('/start'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textPrimaryLight,
                  foregroundColor: AppColors.bgLight,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 32,
                    vertical: isMobile ? 16 : 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Start Your Project',
                      style: AppTypography.buttonText(
                        color: AppColors.bgLight,
                        scale: scale,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 18, color: AppColors.bgLight),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: OutlinedButton(
                onPressed: () => context.go('/services'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimaryLight,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 28,
                    vertical: isMobile ? 16 : 20,
                  ),
                  side: const BorderSide(color: AppColors.textPrimaryLight, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'View Services',
                  style: AppTypography.buttonText(
                    color: AppColors.textPrimaryLight,
                    scale: scale,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // FAQ Item Builder with Smooth Single-Selection Expansion
  Widget _buildFaqItem({
    required int index,
    required String question,
    required String answer,
  }) {
    final isExpanded = _expandedFaqIndex == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded ? AppColors.textPrimaryLight : AppColors.borderLight,
          width: isExpanded ? 1.5 : 1.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _expandedFaqIndex = isExpanded ? null : index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          question,
                          style: AppTypography.heading3(
                            color: AppColors.textPrimaryLight,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 16),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 250),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isExpanded ? AppColors.textPrimaryLight : AppColors.surfaceSubtleLight,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: isExpanded ? AppColors.bgLight : AppColors.textPrimaryLight,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Divider(color: AppColors.borderLight, height: 1),
                        const SizedBox(height: 16),
                        Text(
                          answer,
                          style: AppTypography.bodyMedium(
                            color: AppColors.textSecondaryLight,
                          ).copyWith(height: 1.6),
                        ),
                      ],
                    ),
                    crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 250),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // CTA Primary Button
  Widget _buildPrimaryCtaButton(BuildContext context, double scale, {required bool isMobile}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        onPressed: () => context.go('/start'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textPrimaryLight,
          foregroundColor: AppColors.bgLight,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 32 : 40,
            vertical: isMobile ? 18 : 22,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start Project Brief',
              style: AppTypography.buttonText(
                color: AppColors.bgLight,
                scale: scale,
              ).copyWith(fontWeight: FontWeight.bold, fontSize: 15 * scale),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_rounded, size: 20, color: AppColors.bgLight),
          ],
        ),
      ),
    );
  }

  // CTA WhatsApp Direct Button
  Widget _buildWhatsAppButton(double scale, {required bool isMobile}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: OutlinedButton(
        onPressed: () => _launchUrl('https://wa.me/${AppConfig.whatsappNumber}'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimaryLight,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 28 : 36,
            vertical: isMobile ? 18 : 22,
          ),
          side: const BorderSide(color: AppColors.textPrimaryLight, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat_bubble_outline_rounded, size: 18, color: AppColors.textPrimaryLight),
            const SizedBox(width: 8),
            Text(
              'Chat on WhatsApp',
              style: AppTypography.buttonText(
                color: AppColors.textPrimaryLight,
                scale: scale,
              ).copyWith(fontWeight: FontWeight.w600, fontSize: 15 * scale),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SUPPORTING WIDGET COMPONENTS
// ==========================================

/// Smooth Staggered Fade+Slide In Animation for Landing Sections
class _ScrollEntranceAnimation extends StatefulWidget {
  final Widget child;
  final int staggerIndex;

  const _ScrollEntranceAnimation({
    required this.child,
    this.staggerIndex = 0,
  });

  @override
  State<_ScrollEntranceAnimation> createState() => _ScrollEntranceAnimationState();
}

class _ScrollEntranceAnimationState extends State<_ScrollEntranceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<double>(begin: 28.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Staggered delay: each section starts 80ms after the previous one
    final delay = Duration(milliseconds: widget.staggerIndex * 80);
    Future.delayed(delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_controller.isCompleted) {
          return RepaintBoundary(child: widget.child);
        }
        return RepaintBoundary(
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Hero Supporting Visual Studio Info Card
class _HeroVisualCard extends StatelessWidget {
  const _HeroVisualCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimaryLight, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 32,
            spreadRadius: -4,
            offset: Offset(0, 16),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.statusAvailable,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'STUDIO PROFILE & SPECS',
                    style: AppTypography.labelUppercase(color: AppColors.textPrimaryLight).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubtleLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Text(
                  'Figma & Photoshop',
                  style: AppTypography.bodySmall(color: AppColors.textSecondaryLight).copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Spec item 1
          const _SpecRow(
            title: 'Primary Speciality',
            detail: 'Poster & Campaign Visuals',
            subtext: 'High-impact typography & clear visual hierarchy',
          ),
          const Divider(color: AppColors.borderLight, height: 24),

          // Spec item 2
          const _SpecRow(
            title: 'Turnaround Target',
            detail: '48 – 72 Hours',
            subtext: 'Fast execution for events & announcements',
          ),
          const Divider(color: AppColors.borderLight, height: 24),

          // Spec item 3
          const _SpecRow(
            title: 'Client Focus',
            detail: 'Campus Fests, Startups & Clubs',
            subtext: 'Also providing hands-on design training',
          ),
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String title;
  final String detail;
  final String subtext;

  const _SpecRow({
    required this.title,
    required this.detail,
    required this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTypography.labelUppercase(color: AppColors.textMutedLight).copyWith(
            fontSize: 10,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          detail,
          style: AppTypography.heading3(color: AppColors.textPrimaryLight).copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtext,
          style: AppTypography.bodySmall(color: AppColors.textSecondaryLight).copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

/// Comparison Matrix Widget: Last-Minute DIY vs StudioProof
class _LastMinuteVsStudioProofComparison extends StatelessWidget {
  const _LastMinuteVsStudioProofComparison();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimaryLight, width: 1.5),
      ),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.compare_arrows_rounded, size: 24, color: AppColors.textPrimaryLight),
              const SizedBox(width: 10),
              Text(
                'THE VISUAL DIRECTION COMPARISON',
                style: AppTypography.labelUppercase(color: AppColors.textPrimaryLight).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 600;
              if (isNarrow) {
                return Column(
                  children: [
                    _buildComparisonColumn('Last-Minute / DIY Design', [
                      'Turnaround: Unpredictable delays',
                      'Typography: Overcrowded & hard to read',
                      'Layout: Disconnected social & print graphics',
                      'Impact: Blends into noisy social feeds',
                    ], isBetter: false),
                    const SizedBox(height: 20),
                    _buildComparisonColumn('StudioProof Direction', [
                      'Turnaround: Reliable 48–72h delivery',
                      'Typography: Clear, bold visual hierarchy',
                      'Layout: Cohesive post, story & banner suite',
                      'Impact: High-contrast visuals that convert',
                    ], isBetter: true),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildComparisonColumn('Last-Minute / DIY Design', [
                      'Turnaround: Unpredictable delays',
                      'Typography: Overcrowded & hard to read',
                      'Layout: Disconnected social & print graphics',
                      'Impact: Blends into noisy social feeds',
                    ], isBetter: false),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: _buildComparisonColumn('StudioProof Direction', [
                      'Turnaround: Reliable 48–72h delivery',
                      'Typography: Clear, bold visual hierarchy',
                      'Layout: Cohesive post, story & banner suite',
                      'Impact: High-contrast visuals that convert',
                    ], isBetter: true),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonColumn(String title, List<String> points, {required bool isBetter}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isBetter ? AppColors.bgLight : AppColors.surfaceSubtleLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isBetter ? AppColors.textPrimaryLight : AppColors.borderLight,
          width: isBetter ? 2.0 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.heading3(
              color: AppColors.textPrimaryLight,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(
                    isBetter ? Icons.check_circle_rounded : Icons.cancel_rounded,
                    size: 18,
                    color: isBetter ? AppColors.statusAvailable : AppColors.textMutedLight,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      p,
                      style: AppTypography.bodySmall(
                        color: AppColors.textPrimaryLight,
                      ).copyWith(fontWeight: isBetter ? FontWeight.w600 : FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Feature & Value Card Component
class _FeatureValueCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _FeatureValueCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.textPrimaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.bgLight, size: 24),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.heading2(color: AppColors.textPrimaryLight).copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTypography.bodyLarge(color: AppColors.textSecondaryLight).copyWith(
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Step Card Component for "How It Works"
class _StepCard extends StatelessWidget {
  final String stepNumber;
  final String title;
  final String description;

  const _StepCard({
    required this.stepNumber,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.textPrimaryLight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              stepNumber,
              style: AppTypography.labelUppercase(color: AppColors.bgLight).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppTypography.heading3(color: AppColors.textPrimaryLight).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTypography.bodyMedium(color: AppColors.textSecondaryLight).copyWith(
              height: 1.55,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
