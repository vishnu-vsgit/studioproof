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
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(
      context,
    );
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return PageScaffold(
      currentPath: '/about',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Hero Header
          Container(
            width: double.infinity,
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
                      'ABOUT STUDIOPROOF',
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
                    const SizedBox(height: 24),
                    Text(
                      'StudioProof is an independent graphic design platform focused on posters, campaign identities, and visual systems for campus events, startups, and creators.',
                      style: AppTypography.bodyLarge(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
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

          // 2. The Practice & Story Section (Aligned 2-Column on Desktop, 1-Column on Mobile)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 48.0 : 80.0,
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
                          _buildStoryContent(isDark),
                          const SizedBox(height: 48),
                          _buildQuickFacts(isDark),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 6, child: _buildStoryContent(isDark)),
                          const SizedBox(width: 64),
                          Expanded(flex: 4, child: _buildQuickFacts(isDark)),
                        ],
                      ),
              ),
            ),
          ),

          Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            height: 1,
          ),

          // 3. Core Stack (Tools of Choice)
          Container(
            width: double.infinity,
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
                      'CORE STACK',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Primary Tools of Choice',
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
                    isMobile
                        ? Column(
                            children: [
                              _buildToolCard(
                                isDark: isDark,
                                icon: Icons.crop_square_rounded,
                                name: 'Figma',
                                description:
                                    'Layout composition, vector systems, typography grids, and digital asset production.',
                              ),
                              const SizedBox(height: 20),
                              _buildToolCard(
                                isDark: isDark,
                                icon: Icons.brush_rounded,
                                name: 'Adobe Photoshop',
                                description:
                                    'Photo editing, poster texturing, realistic mockups, and print pre-press preparation.',
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: _buildToolCard(
                                  isDark: isDark,
                                  icon: Icons.crop_square_rounded,
                                  name: 'Figma',
                                  description:
                                      'Layout composition, vector systems, typography grids, and digital asset production.',
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildToolCard(
                                  isDark: isDark,
                                  icon: Icons.brush_rounded,
                                  name: 'Adobe Photoshop',
                                  description:
                                      'Photo editing, poster texturing, realistic mockups, and print pre-press preparation.',
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

          // 4. Design Principles
          Container(
            width: double.infinity,
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
                    isMobile
                        ? Column(
                            children: const [
                              _PhilosophyCard(
                                number: '01',
                                title: 'Typography First',
                                body:
                                    'Words are the core of communication. Strong, intentional typography establishes character long before decoration is added.',
                              ),
                              SizedBox(height: 20),
                              _PhilosophyCard(
                                number: '02',
                                title: 'Restrained & Intentional',
                                body:
                                    'Every grid margin, line, and color choice serves a specific purpose. We eliminate visual clutter to let the message lead.',
                              ),
                              SizedBox(height: 20),
                              _PhilosophyCard(
                                number: '03',
                                title: 'Built for Real Application',
                                body:
                                    'Assets are designed for real use—performing cleanly whether printed on physical posters or displayed on mobile feeds.',
                              ),
                            ],
                          )
                        : Row(
                            children: const [
                              Expanded(
                                child: _PhilosophyCard(
                                  number: '01',
                                  title: 'Typography First',
                                  body:
                                      'Words are the core of communication. Strong, intentional typography establishes character long before decoration is added.',
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                child: _PhilosophyCard(
                                  number: '02',
                                  title: 'Restrained & Intentional',
                                  body:
                                      'Every grid margin, line, and color choice serves a specific purpose. We eliminate visual clutter to let the message lead.',
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                child: _PhilosophyCard(
                                  number: '03',
                                  title: 'Built for Real Application',
                                  body:
                                      'Assets are designed for real use—performing cleanly whether printed on physical posters or displayed on mobile feeds.',
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),

          // 5. Call to Action Banner
          Container(
            width: double.infinity,
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
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
                  children: [
                    Text(
                      'Ready to start your project?',
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
                    const SizedBox(height: 16),
                    Text(
                      'Open for select graphic design commissions, event branding, and creative partnerships.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => context.go('/start-a-project'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryContent(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PRACTICE & BACKGROUND',
          style: AppTypography.labelUppercase(color: AppColors.accent),
        ),
        const SizedBox(height: 16),
        Text(
          'Crafting visual clarity with focused creative momentum.',
          style: AppTypography.heading1(
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'StudioProof was created to bridge the gap between compelling ideas and visual execution. Many student organizations, college fest committees, early-stage startups, and independent creators have great stories, but lack distinct visual identity.',
          style: AppTypography.bodyLarge(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'As a final-year student balancing academic discipline with design commissions, I approach every project with curiosity, precision, and efficiency. Each piece is tailored specifically to the client’s message.',
          style: AppTypography.bodyLarge(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickFacts(bool isDark) {
    final facts = [
      {'label': 'FOCUS', 'value': 'Graphic & Campaign Design'},
      {'label': 'CLIENT TYPES', 'value': 'Startups, Businesses & Individuals'},
      {'label': 'LOCATION', 'value': 'India'},
    ];

    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: facts.map((fact) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fact['label']!,
                  style: AppTypography.labelUppercase(
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  fact['value']!,
                  style: AppTypography.heading3(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildToolCard({
    required bool isDark,
    required IconData icon,
    required String name,
    required String description,
  }) {
    return Container(
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
          Icon(icon, size: 36, color: AppColors.accent),
          const SizedBox(height: 16),
          Text(
            name,
            style: AppTypography.heading2(
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
      ),
    );
  }
}
