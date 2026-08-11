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

/// Full Page Editorial Skeleton View
class PageSkeleton extends StatelessWidget {
  const PageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final horizontalPadding =
        ResponsiveBreakpoints.getHorizontalPadding(context);

    return SkeletonLoader(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: isMobile ? 32.0 : 64.0,
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: ResponsiveBreakpoints.maxContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Label Skeleton
                const SkeletonBox(
                  width: 130,
                  height: 14,
                  customColor: AppColors.accent,
                ),
                const SizedBox(height: 20),
                // Display Headline Skeleton
                SkeletonBox(
                  width: isMobile ? 260 : 540,
                  height: 48,
                ),
                const SizedBox(height: 12),
                SkeletonBox(
                  width: isMobile ? 200 : 380,
                  height: 48,
                ),
                const SizedBox(height: 24),
                // Body Copy Skeletons
                const SkeletonBox(width: double.infinity, height: 16),
                const SizedBox(height: 10),
                const SkeletonBox(width: 320, height: 16),
                const SizedBox(height: 48),
                // Cards Grid Skeleton
                if (isMobile)
                  Column(
                    children: const [
                      SkeletonBox(width: double.infinity, height: 220),
                      SizedBox(height: 20),
                      SkeletonBox(width: double.infinity, height: 220),
                    ],
                  )
                else
                  Row(
                    children: const [
                      Expanded(child: SkeletonBox(height: 240)),
                      SizedBox(width: 24),
                      Expanded(child: SkeletonBox(height: 240)),
                      SizedBox(width: 24),
                      Expanded(child: SkeletonBox(height: 240)),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
