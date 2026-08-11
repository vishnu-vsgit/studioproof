import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 48.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: ResponsiveBreakpoints.maxContentWidth),
          child: Column(
            children: [
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/header_logo.png',
                      height: 28,
                      fit: BoxFit.contain,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      errorBuilder: (context, error, stackTrace) => Text(
                        AppConfig.studioName,
                        style: AppTypography.heading2(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${AppConfig.studioTagline}.',
                      style: AppTypography.bodySmall(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        _FooterLink(
                          label: 'Services',
                          onTap: () => context.go('/services'),
                        ),
                        _FooterLink(
                          label: 'About',
                          onTap: () => context.go('/about'),
                        ),
                        _FooterLink(
                          label: 'Contact',
                          onTap: () => context.go('/contact'),
                        ),
                        _FooterLink(
                          label: 'Start a project →',
                          onTap: () => context.go('/start-a-project'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        _FooterLink(
                          label: AppConfig.contactEmail,
                          onTap: () =>
                              _launchUrl('mailto:${AppConfig.contactEmail}'),
                        ),
                        _FooterLink(
                          label: 'Instagram',
                          onTap: () => _launchUrl(AppConfig.instagramUrl),
                        ),
                        _FooterLink(
                          label: 'WhatsApp',
                          onTap: () => _launchUrl(
                              'https://wa.me/${AppConfig.whatsappNumber}'),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Column
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/header_logo.png',
                            height: 40,
                            fit: BoxFit.contain,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            errorBuilder: (context, error, stackTrace) => Text(
                              AppConfig.studioName,
                              style: AppTypography.heading2(
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${AppConfig.studioTagline}.',
                            style: AppTypography.bodyMedium(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Available for select freelance & recurring design partnerships.',
                            style: AppTypography.bodySmall(
                              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Quick Navigation Links
                    Expanded(
                      flex: 3,
                      child: _FooterNavGroup(isDark: isDark),
                    ),

                    // Social & Contact Channels
                    Expanded(
                      flex: 3,
                      child: _FooterSocialGroup(isDark: isDark, launchUrl: _launchUrl),
                    ),
                  ],
                ),

              const SizedBox(height: 48),
              Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight),
              const SizedBox(height: 24),

              // Bottom Line: Copyright & Tagline
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '© ${DateTime.now().year} ${AppConfig.studioName}. All rights reserved.',
                      style: AppTypography.bodySmall(
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Designed & built with curiosity.',
                      style: AppTypography.bodySmall(
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                        scale: scale,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '© ${DateTime.now().year} ${AppConfig.studioName}. All rights reserved.',
                      style: AppTypography.bodySmall(
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                        scale: scale,
                      ),
                    ),
                    Text(
                      'Designed & built with curiosity.',
                      style: AppTypography.bodySmall(
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                        scale: scale,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterNavGroup extends StatelessWidget {
  final bool isDark;

  const _FooterNavGroup({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NAVIGATION',
          style: AppTypography.labelUppercase(
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
        const SizedBox(height: 16),
        _FooterLink(label: 'Services & Offerings', onTap: () => context.go('/services')),
        const SizedBox(height: 8),
        _FooterLink(label: 'About Studio', onTap: () => context.go('/about')),
        const SizedBox(height: 8),
        _FooterLink(label: 'Start a Project', onTap: () => context.go('/contact')),
      ],
    );
  }
}

class _FooterSocialGroup extends StatelessWidget {
  final bool isDark;
  final Function(String) launchUrl;

  const _FooterSocialGroup({
    required this.isDark,
    required this.launchUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONNECT',
          style: AppTypography.labelUppercase(
            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
          ),
        ),
        const SizedBox(height: 16),
        _FooterLink(
          label: 'Email: ${AppConfig.contactEmail}',
          onTap: () => launchUrl('mailto:${AppConfig.contactEmail}'),
        ),
        const SizedBox(height: 8),
        _FooterLink(
          label: 'Instagram: ${AppConfig.instagramHandle}',
          onTap: () => launchUrl(AppConfig.instagramUrl),
        ),
        const SizedBox(height: 8),
        _FooterLink(
          label: 'WhatsApp Enquiry',
          onTap: () => launchUrl('https://wa.me/${AppConfig.whatsappNumber}'),
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({
    required this.label,
    required this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: AppTypography.bodyMedium(
            color: _isHovered
                ? AppColors.accent
                : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
          ),
        ),
      ),
    );
  }
}
