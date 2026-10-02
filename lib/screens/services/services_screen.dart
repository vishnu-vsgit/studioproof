import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';
import '../../widgets/common/kinetic_marquee_widget.dart';
import '../../widgets/layout/page_scaffold.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

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

    final services = [
      _ServiceItem(
        number: '01',
        title: 'Poster & Campaign Design',
        path: '/start?type=poster',
      ),
      _ServiceItem(
        number: '02',
        title: 'Social Media & Content Design',
        path: '/start?type=social',
      ),
      _ServiceItem(
        number: '03',
        title: 'Event & Fest Visual Identity',
        path: '/start?type=event',
      ),
      _ServiceItem(
        number: '04',
        title: 'Startup & Business Collateral',
        path: '/start?type=startup',
      ),
      _ServiceItem(
        number: '05',
        title: 'Design Training & Workshops',
        path: '/start?type=training',
      ),
      _ServiceItem(
        number: '06',
        title: 'Monthly Design Retainer',
        path: '/start?type=retainer',
      ),
    ];

    return Title(
      title: 'Services & Capabilities — ${AppConfig.studioName}',
      color: AppColors.bgLight,
      child: PageScaffold(
        currentPath: '/services',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. EDITORIAL HERO SECTION ──────────────────────────────
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
                                    'CAPABILITIES & SERVICES',
                                    style: AppTypography.labelUppercase(
                                      color: AppColors.textPrimaryLight,
                                      scale: scale,
                                    ).copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11 * scale,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Text(
                                'Design disciplines crafted for clarity and impact.',
                                style: AppTypography.heading1(
                                  color: AppColors.textPrimaryLight,
                                  scale: scale,
                                ).copyWith(
                                  fontSize: 32 * scale,
                                  height: 1.12,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'High-impact posters, campus event identities, content graphics, and hands-on design training built with sharp typography and fast turnarounds.',
                                style: AppTypography.bodyLarge(
                                  color: AppColors.textSecondaryLight,
                                  scale: scale,
                                ).copyWith(height: 1.5),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
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
                                          'CAPABILITIES & SERVICES',
                                          style: AppTypography.labelUppercase(
                                            color: AppColors.textPrimaryLight,
                                            scale: scale,
                                          ).copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11 * scale,
                                            letterSpacing: 2.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Design disciplines crafted for clarity and real impact.',
                                      style: AppTypography.displayMedium(
                                        color: AppColors.textPrimaryLight,
                                        scale: scale,
                                      ).copyWith(
                                        fontSize: 44 * scale,
                                        height: 1.05,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 580),
                                      child: Text(
                                        'From high-impact posters and campus event identities to social graphics and hands-on workshops, we deliver distinct visual direction for events, startups, and creators.',
                                        style: AppTypography.bodyLarge(
                                          color: AppColors.textSecondaryLight,
                                          scale: scale,
                                        ).copyWith(height: 1.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 64),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceLight,
                                    border: Border.all(color: AppColors.borderLight),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'STUDIO DISCIPLINES',
                                        style: AppTypography.labelUppercase(
                                          color: AppColors.posterClay,
                                          scale: scale,
                                        ).copyWith(
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      _buildHeroMetric(
                                        '06',
                                        'Core Specialized Services',
                                        scale,
                                      ),
                                      const SizedBox(height: 14),
                                      const Divider(color: AppColors.borderLight, height: 1),
                                      const SizedBox(height: 14),
                                      _buildHeroMetric(
                                        '24–48h',
                                        'Fast First Drafts Turnaround',
                                        scale,
                                      ),
                                      const SizedBox(height: 14),
                                      const Divider(color: AppColors.borderLight, height: 1),
                                      const SizedBox(height: 14),
                                      _buildHeroMetric(
                                        'Digital Assets',
                                        'High-Res Soft Copies & Figma/PSD',
                                        scale,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ── 2. KINETIC MARQUEE ────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              color: AppColors.bgLight,
              child: const KineticMarqueeWidget(
                text: 'POSTER DESIGN • EVENT IDENTITIES • SOCIAL CAROUSELS • FIGMA WORKSHOPS • PITCH DECKS • DESIGN TRAINING',
                fontSize: 44,
                opacity: 0.12,
                speed: 38.0,
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ── 3. CLEAN EDITORIAL SERVICE HEADINGS (GRID) ────────────────
            _ScrollEntranceAnimation(
              staggerIndex: 1,
              child: Container(
                width: double.infinity,
                color: AppColors.surfaceLight,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isMobile ? 44.0 : 72.0,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: ResponsiveBreakpoints.maxContentWidth,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final isDesktop = width >= 960;

                        if (isDesktop) {
                          return Column(
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: _MinimalServiceCard(
                                        service: services[0],
                                        scale: scale,
                                        onTap: () => context.go(services[0].path),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: _MinimalServiceCard(
                                        service: services[1],
                                        scale: scale,
                                        onTap: () => context.go(services[1].path),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: _MinimalServiceCard(
                                        service: services[2],
                                        scale: scale,
                                        onTap: () => context.go(services[2].path),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: _MinimalServiceCard(
                                        service: services[3],
                                        scale: scale,
                                        onTap: () => context.go(services[3].path),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: _MinimalServiceCard(
                                        service: services[4],
                                        scale: scale,
                                        onTap: () => context.go(services[4].path),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: _MinimalServiceCard(
                                        service: services[5],
                                        scale: scale,
                                        onTap: () => context.go(services[5].path),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        // Mobile Single-Column Stack
                        return Column(
                          children: services.map((s) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _MinimalServiceCard(
                                service: s,
                                scale: scale,
                                onTap: () => context.go(s.path),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // ── 4. UPGRADED EDITORIAL CTA SECTION ────────────────────────
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
                    padding: EdgeInsets.all(isMobile ? 28.0 : 48.0),
                    decoration: BoxDecoration(
                      color: AppColors.bgLight,
                      border: Border.all(color: AppColors.borderLight),
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
                                      color: AppColors.posterClay,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'READY TO CREATE?',
                                    style: AppTypography.labelUppercase(
                                      color: AppColors.posterClay,
                                      scale: scale,
                                    ).copyWith(
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Text(
                                "Let's build high-impact visuals together.",
                                style: AppTypography.heading1(
                                  color: AppColors.textPrimaryLight,
                                  scale: scale,
                                ).copyWith(
                                  fontSize: 30 * scale,
                                  height: 1.15,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Have an upcoming campus fest, marketing campaign, or need workshop training? Send your brief today.',
                                style: AppTypography.bodyLarge(
                                  color: AppColors.textSecondaryLight,
                                  scale: scale,
                                ).copyWith(height: 1.5),
                              ),
                              const SizedBox(height: 28),
                              _CtaActionCard(
                                title: 'Start a Project Brief',
                                subtitle: 'Online brief submission with quick response',
                                isPrimary: true,
                                scale: scale,
                                onTap: () => context.go('/start'),
                              ),
                              const SizedBox(height: 12),
                              _CtaActionCard(
                                title: 'Direct WhatsApp Chat',
                                subtitle: 'Instant chat & consultation on WhatsApp',
                                isPrimary: false,
                                icon: Icons.chat_bubble_outline_rounded,
                                scale: scale,
                                onTap: () => _launchUrl('https://wa.me/${AppConfig.whatsappNumber}'),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: AppColors.posterClay,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'READY TO CREATE?',
                                          style: AppTypography.labelUppercase(
                                            color: AppColors.posterClay,
                                            scale: scale,
                                          ).copyWith(
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 2.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                    Text(
                                      "Let's build high-impact visuals together.",
                                      style: AppTypography.displayMedium(
                                        color: AppColors.textPrimaryLight,
                                        scale: scale,
                                      ).copyWith(
                                        fontSize: 40 * scale,
                                        height: 1.08,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 520),
                                      child: Text(
                                        'Have an upcoming campus fest, marketing campaign, brand launch, or need workshop training? Send your brief today for fast digital delivery.',
                                        style: AppTypography.bodyLarge(
                                          color: AppColors.textSecondaryLight,
                                          scale: scale,
                                        ).copyWith(height: 1.55),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.bolt_rounded,
                                          size: 16,
                                          color: AppColors.posterClay,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'First response within 24h · 100% Digital Soft Copies & Source Files',
                                          style: AppTypography.bodySmall(
                                            color: AppColors.textMutedLight,
                                            scale: scale,
                                          ).copyWith(fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 48),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    _CtaActionCard(
                                      title: 'Start a Project Brief',
                                      subtitle: 'Submit requirements online in 2 mins',
                                      isPrimary: true,
                                      scale: scale,
                                      onTap: () => context.go('/start'),
                                    ),
                                    const SizedBox(height: 14),
                                    _CtaActionCard(
                                      title: 'Direct WhatsApp Chat',
                                      subtitle: 'Fast creative consultation & queries',
                                      isPrimary: false,
                                      icon: Icons.chat_bubble_outline_rounded,
                                      scale: scale,
                                      onTap: () => _launchUrl('https://wa.me/${AppConfig.whatsappNumber}'),
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
          ],
        ),
      ),
    );
  }

  Widget _buildHeroMetric(String value, String label, double scale) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value,
          style: AppTypography.heading2(
            color: AppColors.textPrimaryLight,
            scale: scale,
          ).copyWith(
            fontSize: 20 * scale,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: AppTypography.bodySmall(
              color: AppColors.textSecondaryLight,
              scale: scale,
            ).copyWith(
              fontSize: 12.5 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// ── DATA MODEL ────────────────────────────────────────────────────────────────

class _ServiceItem {
  final String number;
  final String title;
  final String path;

  const _ServiceItem({
    required this.number,
    required this.title,
    required this.path,
  });
}

// ── MINIMAL SERVICE CARD (HEADINGS ONLY) ──────────────────────────────────────

class _MinimalServiceCard extends StatefulWidget {
  final _ServiceItem service;
  final double scale;
  final VoidCallback onTap;

  const _MinimalServiceCard({
    required this.service,
    required this.scale,
    required this.onTap,
  });

  @override
  State<_MinimalServiceCard> createState() => _MinimalServiceCardState();
}

class _MinimalServiceCardState extends State<_MinimalServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          decoration: BoxDecoration(
            color: AppColors.bgLight,
            border: Border.all(
              color: _isHovered
                  ? AppColors.textPrimaryLight
                  : AppColors.borderLight,
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Monospace number
              Text(
                widget.service.number,
                style: AppTypography.heading1(
                  color: _isHovered
                      ? AppColors.posterClay
                      : AppColors.textMutedLight,
                ).copyWith(
                  fontSize: 28 * widget.scale,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 24),

              // Title
              Expanded(
                child: Text(
                  widget.service.title,
                  style: AppTypography.heading2(
                    color: AppColors.textPrimaryLight,
                    scale: widget.scale,
                  ).copyWith(
                    fontSize: 22 * widget.scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Hover arrow indicator
              AnimatedSlide(
                offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 20 * widget.scale,
                  color: _isHovered
                      ? AppColors.posterClay
                      : AppColors.textMutedLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── CTA ACTION CARD ─────────────────────────────────────────────────────────

class _CtaActionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isPrimary;
  final IconData? icon;
  final double scale;
  final VoidCallback onTap;

  const _CtaActionCard({
    required this.title,
    required this.subtitle,
    required this.isPrimary,
    this.icon,
    required this.scale,
    required this.onTap,
  });

  @override
  State<_CtaActionCard> createState() => _CtaActionCardState();
}

class _CtaActionCardState extends State<_CtaActionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isPrimary
        ? (_isHovered ? const Color(0xFF1E1E1E) : AppColors.textPrimaryLight)
        : (_isHovered ? AppColors.surfaceSubtleLight : AppColors.surfaceLight);

    final titleColor = widget.isPrimary ? Colors.white : AppColors.textPrimaryLight;
    final subColor = widget.isPrimary ? Colors.white.withValues(alpha: 0.75) : AppColors.textSecondaryLight;
    final borderColor = widget.isPrimary
        ? Colors.transparent
        : (_isHovered ? AppColors.textPrimaryLight : AppColors.borderLight);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 20 * widget.scale, color: titleColor),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTypography.buttonText(
                        color: titleColor,
                        scale: widget.scale,
                      ).copyWith(
                        fontSize: 15 * widget.scale,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: AppTypography.bodySmall(
                        color: subColor,
                        scale: widget.scale,
                      ).copyWith(fontSize: 12 * widget.scale),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              AnimatedSlide(
                offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 18 * widget.scale,
                  color: titleColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ── SCROLL ENTRANCE ANIMATION ─────────────────────────────────────────────────

class _ScrollEntranceAnimation extends StatefulWidget {
  final Widget child;
  final int staggerIndex;

  const _ScrollEntranceAnimation({
    required this.child,
    required this.staggerIndex,
  });

  @override
  State<_ScrollEntranceAnimation> createState() =>
      _ScrollEntranceAnimationState();
}

class _ScrollEntranceAnimationState extends State<_ScrollEntranceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.025),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(Duration(milliseconds: 40 * widget.staggerIndex), () {
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
