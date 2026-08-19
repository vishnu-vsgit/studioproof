import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../widgets/layout/page_scaffold.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return PageScaffold(
      currentPath: '/privacy-policy',
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
                      'Privacy Policy',
                      style: isMobile
                          ? AppTypography.heading2(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            )
                          : AppTypography.displaySmall(
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

          // Main Legal Body Content
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 28.0 : 48.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 820.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      isDark: isDark,
                      title: '1. Overview',
                      content:
                          '${AppConfig.studioName} ("we", "our", or "us") respects your privacy and is committed to protecting the personal information you share with us when inquiring about graphic design services, commissioning project work, or communicating via our website (${AppConfig.contactEmail}).',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '2. Information We Collect',
                      content:
                          'When you submit a project brief or reach out via our contact form, email, or WhatsApp, we collect details voluntarily provided by you, including:\n'
                          '• Your name and contact email address\n'
                          '• Organization, club, or company name (if applicable)\n'
                          '• Project scope, budget range, and timeline preferences\n'
                          '• Any design briefs, logos, or reference files you provide.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '3. How We Use Your Information',
                      content:
                          'We use the information collected strictly for legitimate business purposes:\n'
                          '• To review your design request and provide accurate quotes\n'
                          '• To communicate regarding design drafts, feedback, and final deliverables\n'
                          '• To send administrative updates regarding active design commissions\n'
                          'We do NOT sell, rent, trade, or share your personal information with third parties for marketing purposes.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '4. Third-Party Form & Communication Services',
                      content:
                          'Our site utilizes trusted third-party services to process inquiries:\n'
                          '• FormSubmit.co: Form processing service that securely forwards form submissions to ${AppConfig.contactEmail}.\n'
                          '• WhatsApp (Meta): Direct chat links that allow you to initiate project chats directly.\n'
                          '• Vercel / GitHub: Web infrastructure providing SSL encryption (HTTPS) for data transmitted over the web.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '5. Data Security & Storage',
                      content:
                          'We maintain appropriate technical security measures (including HTTPS encryption and restricted access controls) to prevent accidental loss or unauthorized access to your project inquiries.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '6. Your Rights & Data Deletion',
                      content:
                          'You have the right to request access to or deletion of any inquiry records we hold. If you wish to have your contact details removed from our records, please email us at ${AppConfig.contactEmail}.',
                    ),
                    _buildSection(
                      isDark: isDark,
                      title: '7. Contact Us',
                      content:
                          'For any privacy questions or requests regarding this Privacy Policy, please contact:\n'
                          'Email: ${AppConfig.contactEmail}\n'
                          'WhatsApp: +${AppConfig.whatsappNumber}',
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () => context.go('/start-a-project'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.heading3(
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: AppTypography.bodyMedium(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ).copyWith(height: 1.55),
          ),
        ],
      ),
    );
  }
}
