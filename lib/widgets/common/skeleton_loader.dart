import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/responsive_breakpoints.dart';

/// Reusable Shimmer Skeleton Loader for StudioProof UI components
class SkeletonLoader extends StatefulWidget {
  final Widget child;

  const SkeletonLoader({super.key, required this.child});

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.35, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}

/// Simple Skeleton Box placeholder item
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;
  final Color? customColor;

  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 0,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: customColor ??
            (isDark
                ? AppColors.surfaceSubtleDark
                : AppColors.surfaceSubtleLight),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Full Page Editorial Skeleton View matching the latest layout
class PageSkeleton extends StatelessWidget {
  const PageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final horizontalPadding =
        ResponsiveBreakpoints.getHorizontalPadding(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SkeletonLoader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Hero Section Skeleton
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 28.0 : 48.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.maxContentWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Studio Tagline Badge Pill
                    Row(
                      children: const [
                        SkeletonBox(
                          width: 8,
                          height: 8,
                          borderRadius: 4,
                        ),
                        SizedBox(width: 10),
                        SkeletonBox(width: 120, height: 12),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Headline Skeleton
                    SkeletonBox(
                      width: isMobile ? 260 : 540,
                      height: isMobile ? 36 : 48,
                    ),
                    const SizedBox(height: 12),

                    // Supporting Copy Skeleton
                    const SkeletonBox(width: double.infinity, height: 16),
                    const SizedBox(height: 8),
                    const SkeletonBox(width: 280, height: 16),
                    const SizedBox(height: 20),

                    // Dual CTA Buttons Skeleton
                    Row(
                      children: [
                        SkeletonBox(
                          width: isMobile ? 140 : 160,
                          height: isMobile ? 44 : 52,
                        ),
                        const SizedBox(width: 12),
                        SkeletonBox(
                          width: isMobile ? 100 : 140,
                          height: isMobile ? 44 : 52,
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

          // 2. What We Do (Highlights Grid Skeleton)
          Container(
            width: double.infinity,
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 28.0 : 64.0,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.maxContentWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletonBox(
                      width: 100,
                      height: 12,
                    ),
                    const SizedBox(height: 12),
                    SkeletonBox(
                      width: isMobile ? 240 : 420,
                      height: 28,
                    ),
                    const SizedBox(height: 24),

                    // Responsive 2x2 Grid on Mobile, 4-column Row on Desktop
                    if (isMobile)
                      Column(
                        children: [
                          Row(
                            children: const [
                              Expanded(child: SkeletonBox(height: 110)),
                              SizedBox(width: 12),
                              Expanded(child: SkeletonBox(height: 110)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: const [
                              Expanded(child: SkeletonBox(height: 110)),
                              SizedBox(width: 12),
                              Expanded(child: SkeletonBox(height: 110)),
                            ],
                          ),
                        ],
                      )
                    else
                      Row(
                        children: const [
                          Expanded(child: SkeletonBox(height: 180)),
                          SizedBox(width: 20),
                          Expanded(child: SkeletonBox(height: 180)),
                          SizedBox(width: 20),
                          Expanded(child: SkeletonBox(height: 180)),
                          SizedBox(width: 20),
                          Expanded(child: SkeletonBox(height: 180)),
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

          // 3. Selected Portfolio Carousel Skeleton
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
                    const SkeletonBox(
                      width: 140,
                      height: 12,
                    ),
                    const SizedBox(height: 12),
                    SkeletonBox(
                      width: isMobile ? 220 : 380,
                      height: 28,
                    ),
                    const SizedBox(height: 24),
                    const WorkCarouselSkeleton(),
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

/// Horizontal Work Carousel Skeleton
class WorkCarouselSkeleton extends StatelessWidget {
  const WorkCarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final cardWidth = isMobile ? 290.0 : 340.0;
    final cardHeight = isMobile ? 360.0 : 420.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: List.generate(
          3,
          (index) => Container(
            width: cardWidth,
            height: cardHeight,
            margin: const EdgeInsets.only(right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SkeletonBox(
                    width: cardWidth,
                    height: double.infinity,
                  ),
                ),
                const SizedBox(height: 12),
                const SkeletonBox(width: 180, height: 18),
                const SizedBox(height: 6),
                const SkeletonBox(width: 120, height: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Services Accordion List Skeleton
class ServicesSkeleton extends StatelessWidget {
  const ServicesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        6,
        (index) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  const SkeletonBox(
                    width: 32,
                    height: 24,
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: SkeletonBox(height: 24),
                  ),
                  const SizedBox(width: 16),
                  const SkeletonBox(width: 20, height: 20),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
