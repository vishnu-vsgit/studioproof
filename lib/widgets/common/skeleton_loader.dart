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
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.65, end: 1.0).animate(
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

/// Simple Skeleton Box placeholder item for White/Black theme
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;
  final Color? customColor;

  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 8.0,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: customColor ?? AppColors.surfaceSubtleLight,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1.0,
        ),
      ),
    );
  }
}

/// Full Page Skeleton View matching the active White/Black landing layout
class PageSkeleton extends StatelessWidget {
  const PageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);

    return SkeletonLoader(
      child: Container(
        color: AppColors.bgLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Section Skeleton
            Container(
              width: double.infinity,
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
                          children: const [
                            SkeletonBox(width: 220, height: 16, borderRadius: 20),
                            SizedBox(height: 20),
                            SkeletonBox(width: double.infinity, height: 38),
                            SizedBox(height: 10),
                            SkeletonBox(width: 200, height: 24),
                            SizedBox(height: 18),
                            SkeletonBox(width: double.infinity, height: 48),
                            SizedBox(height: 32),
                            SkeletonBox(width: 180, height: 48, borderRadius: 30),
                            SizedBox(height: 36),
                            SkeletonBox(width: double.infinity, height: 240, borderRadius: 24),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SkeletonBox(width: 240, height: 16, borderRadius: 20),
                                  SizedBox(height: 20),
                                  SkeletonBox(width: 480, height: 52),
                                  SizedBox(height: 12),
                                  SkeletonBox(width: 260, height: 30),
                                  SizedBox(height: 18),
                                  SkeletonBox(width: 420, height: 48),
                                  SizedBox(height: 32),
                                  Row(
                                    children: [
                                      SkeletonBox(width: 160, height: 52, borderRadius: 30),
                                      SizedBox(width: 16),
                                      SkeletonBox(width: 140, height: 52, borderRadius: 30),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 48),
                            const Expanded(
                              flex: 5,
                              child: SkeletonBox(width: double.infinity, height: 280, borderRadius: 24),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // 2. Comparison Matrix Skeleton
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
                    children: const [
                      SkeletonBox(width: 200, height: 14),
                      SizedBox(height: 12),
                      SkeletonBox(width: 320, height: 36),
                      SizedBox(height: 36),
                      SkeletonBox(width: double.infinity, height: 220, borderRadius: 20),
                    ],
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // 3. Services Feature List Skeleton
            Container(
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
                    children: const [
                      SkeletonBox(width: 160, height: 14),
                      SizedBox(height: 12),
                      SkeletonBox(width: 380, height: 36),
                      SizedBox(height: 48),
                      SkeletonBox(width: double.infinity, height: 120, borderRadius: 16),
                      SizedBox(height: 20),
                      SkeletonBox(width: double.infinity, height: 120, borderRadius: 16),
                      SizedBox(height: 20),
                      SkeletonBox(width: double.infinity, height: 120, borderRadius: 16),
                    ],
                  ),
                ),
              ),
            ),

            const Divider(color: AppColors.borderLight, height: 1),

            // 4. Work Carousel Skeleton
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 36.0 : 60.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: ResponsiveBreakpoints.maxContentWidth,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SkeletonBox(width: 180, height: 14),
                            SizedBox(height: 6),
                            SkeletonBox(width: 320, height: 28),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const WorkCarouselSkeleton(),
                ],
              ),
            ),
          ],
        ),
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
    final horizontalPadding = ResponsiveBreakpoints.getHorizontalPadding(context);
    final cardWidth = isMobile ? 290.0 : 340.0;
    final cardHeight = isMobile ? 420.0 : 470.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                    borderRadius: 16,
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
        5,
        (index) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: const [
                  SkeletonBox(width: 32, height: 24),
                  SizedBox(width: 16),
                  Expanded(child: SkeletonBox(height: 24)),
                  SizedBox(width: 16),
                  SkeletonBox(width: 20, height: 20, borderRadius: 10),
                ],
              ),
            ),
            const Divider(color: AppColors.borderLight),
          ],
        ),
      ),
    );
  }
}
