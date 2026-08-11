import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../widgets/layout/page_scaffold.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return PageScaffold(
      currentPath: '/about',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: isMobile ? 40.0 : 72.0,
              bottom: 40.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STUDIO & DESIGNER',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppConfig.designerBioHeadline,
                      style: isMobile
                          ? AppTypography.heading1(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displayLarge(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'I’m a final-year student and graphic designer exploring the intersection of design, technology, and creative practice.',
                      style: AppTypography.bodyLarge(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Divider(),

          // Main Story & Portrait Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: isMobile ? 40.0 : 72.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _DesignerPortraitCard(isDark: isDark),
                          const SizedBox(height: 40),
                          _AboutStoryText(isDark: isDark),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: _DesignerPortraitCard(isDark: isDark),
                          ),
                          const SizedBox(width: 64),
                          Expanded(
                            flex: 6,
                            child: _AboutStoryText(isDark: isDark),
                          ),
                        ],
                      ),
              ),
            ),
          ),

          const Divider(),

          // Tools & Software Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: isMobile ? 40.0 : 72.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CORE STACK',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tools of choice',
                      style: isMobile
                          ? AppTypography.heading1(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displaySmall(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                    ),
                    const SizedBox(height: 32),

                    Row(
                      children: AppConfig.primaryTools.map((tool) {
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 20.0),
                            padding: const EdgeInsets.all(32.0),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                              border: Border.all(
                                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  tool == 'Figma' ? Icons.crop_square_rounded : Icons.brush_rounded,
                                  size: 36,
                                  color: AppColors.accent,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  tool,
                                  style: AppTypography.heading2(
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  tool == 'Figma'
                                      ? 'Layout composition, vector systems, typography grids, and asset export.'
                                      : 'High-resolution photo editing, poster texturing, mockups, and print pre-press.',
                                  style: AppTypography.bodyMedium(
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Divider(),

          // Design Philosophy & Principles Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: isMobile ? 40.0 : 72.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRINCIPLES',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Design Philosophy',
                      style: isMobile
                          ? AppTypography.heading1(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displaySmall(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                    ),
                    const SizedBox(height: 40),

                    if (isMobile)
                      Column(
                        children: const [
                          _PhilosophyCard(
                            number: '01',
                            title: 'Typography First',
                            body: 'Words are the core of communication. Strong, intentional typography creates character long before any decorative graphic is added.',
                          ),
                          SizedBox(height: 24),
                          _PhilosophyCard(
                            number: '02',
                            title: 'Restrained & Intentional',
                            body: 'Every line, grid margin, and color choice must have a reason to exist. Avoid unnecessary visual noise and trendy shortcuts.',
                          ),
                          SizedBox(height: 24),
                          _PhilosophyCard(
                            number: '03',
                            title: 'Built for Real Application',
                            body: 'A poster must look great printed on a campus bulletin board and shared on an Instagram story feed. Function always guides form.',
                          ),
                        ],
                      )
                    else
                      Row(
                        children: const [
                          Expanded(
                            child: _PhilosophyCard(
                              number: '01',
                              title: 'Typography First',
                              body: 'Words are the core of communication. Strong, intentional typography creates character long before any decorative graphic is added.',
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: _PhilosophyCard(
                              number: '02',
                              title: 'Restrained & Intentional',
                              body: 'Every line, grid margin, and color choice must have a reason to exist. Avoid unnecessary visual noise and trendy shortcuts.',
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: _PhilosophyCard(
                              number: '03',
                              title: 'Built for Real Application',
                              body: 'A poster must look great printed on a campus bulletin board and shared on an Instagram story feed. Function always guides form.',
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom CTA
          Container(
            width: double.infinity,
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: isMobile ? 48.0 : 80.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
                child: Column(
                  children: [
                    Text(
                      'Let’s create something distinct.',
                      style: isMobile
                          ? AppTypography.heading1(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displayMedium(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.go('/contact'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesignerPortraitCard extends StatelessWidget {
  final bool isDark;

  const _DesignerPortraitCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Container(
              color: isDark ? const Color(0xFF1B2430) : const Color(0xFFECE8DF),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline_rounded,
                    size: 64,
                    color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'PORTRAIT PLACEHOLDER',
                    style: AppTypography.labelUppercase(
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Independent Studio Practice',
                  style: AppTypography.heading3(
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Final-Year Student & Designer',
                  style: AppTypography.bodySmall(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
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

class _AboutStoryText extends StatelessWidget {
  final bool isDark;

  const _AboutStoryText({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'THE STORY',
          style: AppTypography.labelUppercase(color: AppColors.accent),
        ),
        const SizedBox(height: 16),
        Text(
          'Building an independent studio with craft and momentum.',
          style: AppTypography.heading1(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'This studio began with a simple observation: many great student events, college clubs, early-stage startups, and small businesses have compelling ideas, but struggle to communicate them visually.',
          style: AppTypography.bodyLarge(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'As a final-year student, I balance academic practice with real-world design commissions. I work directly in Figma and Adobe Photoshop to design posters, campaign assets, and brand collateral that stand out.',
          style: AppTypography.bodyLarge(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'The goal is long-term: building this from a dedicated student studio into a recognized independent creative agency known for visual clarity and editorial craft.',
          style: AppTypography.bodyLarge(
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}

class _PhilosophyCard extends StatelessWidget {
  final String number;
  final String title;
  final String body;

  const _PhilosophyCard({
    required this.number,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number, style: AppTypography.heading2(color: AppColors.accent)),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTypography.heading3(
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: AppTypography.bodyMedium(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
