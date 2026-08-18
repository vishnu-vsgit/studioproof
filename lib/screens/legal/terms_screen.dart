import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../widgets/layout/page_scaffold.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return PageScaffold(
      currentPath: '/terms-and-conditions',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: isMobile ? 36.0 : 64.0,
              bottom: 32.0,
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
                      'LEGAL & COMPLIANCE',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Terms & Conditions',
                      style: isMobile
                          ? AppTypography.heading1(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displayLarge(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Last updated: August 2026',
                      style: AppTypography.bodySmall(
                        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Divider(),

          // Main Terms Content Body
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 36.0 : 64.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 900.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      isDark: isDark,
                      title: '1. Services Scope',
                      content:
                          '${AppConfig.studioName} provides independent graphic design services including standalone event posters, campaign key visuals, social media promotional graphics, and monthly recurring design support. Specific project deliverables, budgets, and turnaround timelines are agreed upon individually prior to project commencement.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '2. Intellectual Property & Ownership Rights',
                      content:
                          'Upon full payment of agreed project fees, clients receive full commercial rights to use the delivered final design assets (including production PDFs, PNGs, and social media files) for their intended campaign.\n'
                          '${AppConfig.studioName} retains the right to display completed non-confidential artwork in its online portfolio, website, and promotional showcase.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '3. Client Materials & Warranties',
                      content:
                          'Clients are responsible for providing accurate text briefs, high-resolution logos, and images. Clients warrant that all materials provided for use in design projects do not infringe upon any third-party copyrights or trademarks.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '4. Turnaround Times & Revisions',
                      content:
                          'Turnaround timelines (typically 24 to 48 hours for standard poster deliverables) begin once the project brief and necessary assets are confirmed. Revisions are provided based on the agreed scope during initial project onboarding.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '5. Limitation of Liability',
                      content:
                          '${AppConfig.studioName} strives for the highest graphic design quality and precision. We are not liable for indirect or consequential damages arising from client print misprints where final proofing was approved by the client.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '6. Inquiries & Legal Contact',
                      content:
                          'For any questions regarding these Terms & Conditions, please contact us at:\n'
                          'Email: ${AppConfig.contactEmail}\n'
                          'WhatsApp: +${AppConfig.whatsappNumber}',
                    ),
                    const SizedBox(height: 32),
                    OutlinedButton(
                      onPressed: () => context.go('/start-a-project'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        side: BorderSide(
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                      child: Text(
                        'Back to Start a Project →',
                        style: AppTypography.buttonText(
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
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

  Widget _buildSection({
    required bool isDark,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.heading2(
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: AppTypography.bodyLarge(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ).copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
