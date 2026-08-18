import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../widgets/layout/page_scaffold.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(
      context,
    );
    final scale = ResponsiveBreakpoints.getTypographyScale(context);

    return PageScaffold(
      currentPath: '/services',
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
                constraints: const BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.maxContentWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CAPABILITIES & SERVICES',
                      style: AppTypography.labelUppercase(
                        color: AppColors.accent,
                        scale: scale,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'What we can help with',
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
                    const SizedBox(height: 16),
                    Text(
                      'Direct graphic design services for standalone promotional needs and recurring monthly design partnerships.',
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

          const Divider(),

          // 6 Numbered Services Editorial List
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 40.0 : 72.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.maxContentWidth,
                ),
                child: Column(
                  children: const [
                    _EditorialServiceRow(
                      number: '01',
                      title: 'Poster & Campaign Design',
                      description:
                          'High-impact event posters, festival key visuals, stage backdrops, and promotional print graphics designed to grab attention.',
                      deliverables:
                          'Main Posters, Digital Banners, Print PDFs, Source Files',
                      idealClient:
                          'Colleges, Clubs, Event Organizers, Performers',
                    ),
                    Divider(),
                    _EditorialServiceRow(
                      number: '02',
                      title: 'Social Media Design',
                      description:
                          'Custom Instagram carousel guides, story graphics, feed templates, and YouTube thumbnail designs built for engagement.',
                      deliverables:
                          'Multi-slide Carousels, Story Formats, Feed Templates',
                      idealClient: 'Creators, Student Orgs, Brands, Marketers',
                    ),
                    Divider(),
                    _EditorialServiceRow(
                      number: '03',
                      title: 'Event & College Design',
                      description:
                          'Complete visual identity packages for annual college fests, cultural nights, tech hackathons, and student elections.',
                      deliverables:
                          'Fest Key Visuals, ID Badges, Wristbands, Entry Gates',
                      idealClient:
                          'University Councils, Clubs, Fest Committees',
                    ),
                    Divider(),
                    _EditorialServiceRow(
                      number: '04',
                      title: 'Startup Design',
                      description:
                          'Product launch graphics, pitch deck presentations, social teasers, and feature announcement cards.',
                      deliverables:
                          'Investor Pitch Decks, Product Hunt Creatives, Social Cards',
                      idealClient:
                          'Tech Startups, Early-stage Founders, Incubators',
                    ),
                    Divider(),
                    _EditorialServiceRow(
                      number: '05',
                      title: 'Business Design',
                      description:
                          'Promotional flyers, restaurant menus, product packaging tags, artisan market signage, and marketing collateral.',
                      deliverables:
                          'Print Flyers, Digital Menus, Packaging Collateral',
                      idealClient:
                          'Small Businesses, Local Shops, Cafes, Collectives',
                    ),
                    Divider(),
                    _EditorialServiceRow(
                      number: '06',
                      title: 'Custom Projects',
                      description:
                          'Specialized graphic requests, custom typography layouts, presentation decks, or unique visual challenges.',
                      deliverables:
                          'Tailored Asset Package based on requirements',
                      idealClient: 'Individuals, Companies, Creative Directors',
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Divider(),

          // Dedicated Section A: RECURRING DESIGN SUPPORT
          Container(
            width: double.infinity,
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 48.0 : 88.0,
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
                            'RECURRING RETAINER',
                            style: AppTypography.labelUppercase(
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Need design more than once?',
                            style: AppTypography.heading1(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'For clubs, startups and businesses that constantly need new creatives, ongoing design support is available instead of commissioning every poster separately.',
                            style: AppTypography.bodyLarge(
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
                                horizontal: 28,
                                vertical: 18,
                              ),
                            ),
                            child: Text(
                              'Ask about monthly support →',
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
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RECURRING RETAINER',
                                  style: AppTypography.labelUppercase(
                                    color: AppColors.accent,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Need design more than once?',
                                  style: AppTypography.displaySmall(
                                    color: isDark
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'For clubs, startups and businesses that constantly need new creatives, ongoing design support is available instead of commissioning every poster separately.',
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
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SupportBenefitItem(
                                  text:
                                      'Priority turnarounds on weekly graphics',
                                  isDark: isDark,
                                ),
                                const SizedBox(height: 12),
                                _SupportBenefitItem(
                                  text:
                                      'Direct communication via WhatsApp & email',
                                  isDark: isDark,
                                ),
                                const SizedBox(height: 12),
                                _SupportBenefitItem(
                                  text:
                                      'Predictable monthly billing without surprises',
                                  isDark: isDark,
                                ),
                                const SizedBox(height: 32),
                                ElevatedButton(
                                  onPressed: () => context.go('/start-a-project'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 20,
                                    ),
                                  ),
                                  child: Text(
                                    'Ask about monthly support →',
                                    style: AppTypography.buttonText(
                                      color: Colors.white,
                                    ),
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

          const Divider(),

          // Dedicated Section B: FREELANCE / ONE-OFF DESIGN
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 48.0 : 88.0,
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
                            'STANDALONE PROJECTS',
                            style: AppTypography.labelUppercase(
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Have a single design project?',
                            style: AppTypography.heading1(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Need a poster, campaign creative, presentation, menu or something completely different? Send the details and I’ll get back to you.',
                            style: AppTypography.bodyLarge(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                          const SizedBox(height: 32),
                          OutlinedButton(
                            onPressed: () => context.go('/start-a-project'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                              side: BorderSide(
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 18,
                              ),
                            ),
                            child: Text(
                              'Request a design →',
                              style: AppTypography.buttonText(
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'STANDALONE PROJECTS',
                                  style: AppTypography.labelUppercase(
                                    color: AppColors.accent,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Have a single design project?',
                                  style: AppTypography.displaySmall(
                                    color: isDark
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Need a poster, campaign creative, presentation, menu or something completely different? Send the details and I’ll get back to you.',
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
                          Expanded(
                            flex: 4,
                            child: OutlinedButton(
                              onPressed: () => context.go('/start-a-project'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                                side: BorderSide(
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                                  width: 1.5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 36,
                                  vertical: 22,
                                ),
                              ),
                              child: Text(
                                'Request a design →',
                                style: AppTypography.buttonText(
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                                ),
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

class _EditorialServiceRow extends StatefulWidget {
  final String number;
  final String title;
  final String description;
  final String deliverables;
  final String idealClient;

  const _EditorialServiceRow({
    required this.number,
    required this.title,
    required this.description,
    required this.deliverables,
    required this.idealClient,
  });

  @override
  State<_EditorialServiceRow> createState() => _EditorialServiceRowState();
}

class _EditorialServiceRowState extends State<_EditorialServiceRow> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    if (isMobile) {
      return InkWell(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.number,
                        style: AppTypography.heading3(color: AppColors.accent),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.title,
                        style: AppTypography.heading3(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ).copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.accent,
                    size: 24,
                  ),
                ],
              ),
              if (_isExpanded) ...[
                const SizedBox(height: 12),
                Text(
                  widget.description,
                  style: AppTypography.bodyMedium(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Ideal for: ${widget.idealClient}',
                  style: AppTypography.bodySmall(
                    color: AppColors.accent,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  'Deliverables: ${widget.deliverables}',
                  style: AppTypography.bodySmall(
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.number,
            style: AppTypography.heading1(color: AppColors.accent),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: AppTypography.heading2(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ideal for: ${widget.idealClient}',
                  style: AppTypography.labelUppercase(
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: AppTypography.bodyLarge(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Deliverables: ${widget.deliverables}',
                  style: AppTypography.bodySmall(
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight,
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

class _SupportBenefitItem extends StatelessWidget {
  final String text;
  final bool isDark;

  const _SupportBenefitItem({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          size: 20,
          color: AppColors.accent,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodyMedium(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ),
      ],
    );
  }
}
