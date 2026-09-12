import 'dart:ui';
import 'package:flutter/material.dart';
import '../../models/project_model.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';

class WorkCarouselWidget extends StatefulWidget {
  final List<Project> projects;

  const WorkCarouselWidget({
    super.key,
    required this.projects,
  });

  @override
  State<WorkCarouselWidget> createState() => _WorkCarouselWidgetState();
}

class _WorkCarouselWidgetState extends State<WorkCarouselWidget> {
  late PageController _pageController;
  int _currentIndex = 2; // Start centered (index 2 = middle of 5 items)
  double _viewportFraction = 0.28;
  double _lastCalculatedWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
      viewportFraction: _viewportFraction,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recalculateViewportFraction();
  }

  void _recalculateViewportFraction() {
    final width = MediaQuery.sizeOf(context).width;
    if ((width - _lastCalculatedWidth).abs() < 2.0) return;
    _lastCalculatedWidth = width;

    final isMobile = width < 700;
    final isTablet = width >= 700 && width < 1050;

    // Refined compact poster heights
    final double targetHeight = isMobile ? 310.0 : (isTablet ? 350.0 : 380.0);
    final double posterWidth = targetHeight * 0.77;
    final double gap = isMobile ? 14.0 : 20.0;
    final double desiredSlotWidth = posterWidth + gap;

    // On desktop: show 1 center + 2 partial on each side (~5 visible)
    // On tablet: show 1 center + 1–2 partial on each side
    // On mobile: show 1 center + partial on each side
    final double fraction = (desiredSlotWidth / width).clamp(
      isMobile ? 0.62 : 0.18,
      isMobile ? 0.82 : 0.36,
    );

    if ((fraction - _viewportFraction).abs() > 0.005) {
      _viewportFraction = fraction;
      final int currentIdx = _currentIndex;
      final oldController = _pageController;
      _pageController = PageController(
        initialPage: currentIdx,
        viewportFraction: _viewportFraction,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        oldController.dispose();
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= widget.projects.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 700;
    final isTablet = width >= 700 && width < 1050;
    final scale = ResponsiveBreakpoints.getTypographyScale(context);
    final projects = widget.projects;

    if (projects.isEmpty) return const SizedBox.shrink();

    final double targetHeight = isMobile ? 310.0 : (isTablet ? 350.0 : 380.0);
    final double gap = isMobile ? 14.0 : 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // --- 1. Carousel Gallery Strip (Non-clickable cards, pure visual showcase) ---
        SizedBox(
          height: targetHeight + 16.0,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              },
            ),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              physics: const BouncingScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];

                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double pageOffset = (_currentIndex - index).toDouble();
                    if (_pageController.hasClients &&
                        _pageController.position.haveDimensions) {
                      final page = _pageController.page;
                      if (page != null) {
                        pageOffset = page - index;
                      }
                    }
                    final absOffset = pageOffset.abs();
                    final scaleVal = (1.0 - (absOffset * 0.08)).clamp(0.92, 1.0);
                    final opacityVal = (1.0 - (absOffset * 0.45)).clamp(0.55, 1.0);

                    return RepaintBoundary(
                      child: Transform.scale(
                        scale: scaleVal,
                        child: Opacity(
                          opacity: opacityVal,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: gap / 2),
                            child: Center(
                              child: SizedBox(
                                height: targetHeight,
                                child: AspectRatio(
                                  aspectRatio: project.aspectRatio,
                                  child: _PosterCard(
                                    project: project,
                                    isActive: index == _currentIndex,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 24),

        // --- 2. Minimal Navigation Controls ---
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _NavButton(
                icon: Icons.arrow_back_rounded,
                enabled: _currentIndex > 0,
                onTap: () => _goTo(_currentIndex - 1),
              ),
              const SizedBox(width: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(projects.length, (i) {
                  final isActive = i == _currentIndex;
                  return GestureDetector(
                    onTap: () => _goTo(i),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.textPrimaryLight
                              : AppColors.borderLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(width: 16),
              Text(
                '0${_currentIndex + 1} / 0${projects.length}',
                style: AppTypography.labelUppercase(
                  color: AppColors.textSecondaryLight,
                  scale: scale,
                ).copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12 * scale,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 16),
              _NavButton(
                icon: Icons.arrow_forward_rounded,
                enabled: _currentIndex < projects.length - 1,
                onTap: () => _goTo(_currentIndex + 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PosterCard extends StatelessWidget {
  final Project project;
  final bool isActive;

  const _PosterCard({
    required this.project,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? AppColors.textPrimaryLight
              : AppColors.borderLight,
          width: isActive ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isActive ? 0.12 : 0.04,
            ),
            blurRadius: isActive ? 24 : 8,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          project.imageAsset,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.surfaceSubtleLight,
            alignment: Alignment.center,
            child: const Icon(
              Icons.image_outlined,
              size: 40,
              color: AppColors.textMutedLight,
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: enabled
                ? AppColors.textPrimaryLight
                : AppColors.surfaceSubtleLight,
            border: Border.all(
              color: enabled
                  ? AppColors.textPrimaryLight
                  : AppColors.borderLight,
              width: 1.2,
            ),
          ),
          child: Icon(
            icon,
            size: 16,
            color: enabled ? AppColors.bgLight : AppColors.textMutedLight,
          ),
        ),
      ),
    );
  }
}
