import 'package:flutter/material.dart';
import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/responsive_breakpoints.dart';

/// World-Class "Fullscreen Kinetic Typography & Curtain Sweep" Loading Animation for StudioProof.
/// Features a massive editorial percentage counter (00 -> 100), staggered brand text reveals,
/// and a full-screen canvas curtain wipe revealing the site with smooth spring physics.
class StudioCanvasLoader extends StatefulWidget {
  final String? loadingMessage;
  final VoidCallback? onComplete;

  const StudioCanvasLoader({
    super.key,
    this.loadingMessage = 'Unfolding studio showcase...',
    this.onComplete,
  });

  @override
  State<StudioCanvasLoader> createState() => _StudioCanvasLoaderState();
}

class _StudioCanvasLoaderState extends State<StudioCanvasLoader>
    with TickerProviderStateMixin {
  late AnimationController _counterController;
  late AnimationController _curtainController;

  late Animation<double> _counterProgress;
  late Animation<double> _curtainY;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    // 1. Kinetic Counter Animation (00 to 100%) - Instantaneous Count
    _counterController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // 2. Fullscreen Curtain Sweep Reveal - Instantaneous Wipe
    _curtainController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _counterProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _counterController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _counterController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _counterController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _curtainY = Tween<double>(begin: 0.0, end: -1.0).animate(
      CurvedAnimation(
        parent: _curtainController,
        curve: const Cubic(0.76, 0.0, 0.24, 1.0),
      ),
    );

    _counterController.forward().then((_) {
      if (mounted) {
        _curtainController.forward().then((_) {
          widget.onComplete?.call();
        });
      }
    });
  }

  @override
  void dispose() {
    _counterController.dispose();
    _curtainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);
    final scale = ResponsiveBreakpoints.getTypographyScale(context);
    final size = MediaQuery.sizeOf(context);

    return AnimatedBuilder(
      animation: _curtainController,
      builder: (context, child) {
        final curtainOffset = _curtainY.value * size.height;

        return Stack(
          children: [
            // Underlying Page Container (Exposed during curtain wipe)
            Container(color: AppColors.bgLight),

            // -----------------------------------------------------------------
            // FULLSCREEN KINETIC CURTAIN PANEL
            // -----------------------------------------------------------------
            Transform.translate(
              offset: Offset(0, curtainOffset),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.bgLight,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24.0 : 48.0,
                      vertical: isMobile ? 20.0 : 32.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- 1. TOP HEADER BAR ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  AppConfig.studioName.toUpperCase(),
                                  style: AppTypography.labelUppercase(
                                    color: AppColors.textPrimaryLight,
                                    scale: scale,
                                  ).copyWith(
                                    fontSize: (isMobile ? 11 : 12) * scale,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: isMobile ? 1.5 : 2.5,
                                  ),
                                ),
                              ],
                            ),
                            if (size.width > 340)
                              Text(
                                'INDEPENDENT DESIGN STUDIO',
                                style: AppTypography.labelUppercase(
                                  color: AppColors.textMutedLight,
                                  scale: scale,
                                ).copyWith(
                                  fontSize: (isMobile ? 8.5 : 10) * scale,
                                  letterSpacing: isMobile ? 1.0 : 1.8,
                                ),
                              ),
                          ],
                        ),

                        // --- 2. CENTER GIANT KINETIC COUNTER & EDITORIAL REVEAL ---
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: AnimatedBuilder(
                                animation: _counterController,
                                builder: (context, child) {
                                  final progress = _counterProgress.value;
                                  final percentInt = (progress * 100).toInt();
                                  final formattedPercent = percentInt.toString().padLeft(2, '0');

                                  final counterFontSize = (isMobile
                                      ? (size.width < 380 ? 64.0 : 88.0)
                                      : 150.0) * scale;

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Giant Monospace Counter Display
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Text(
                                              formattedPercent,
                                              style: AppTypography.labelMonoSmall(
                                                color: AppColors.textPrimaryLight,
                                                scale: scale,
                                              ).copyWith(
                                                fontSize: counterFontSize,
                                                fontWeight: FontWeight.w900,
                                                height: 0.95,
                                                letterSpacing: -3.0,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '%',
                                              style: AppTypography.displaySmall(
                                                color: AppColors.posterClay,
                                                scale: scale,
                                              ).copyWith(
                                                fontSize: (isMobile ? 32 : 52) * scale,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      // Staggered Editorial Headline Reveal
                                      Opacity(
                                        opacity: _textOpacity.value,
                                        child: Transform.translate(
                                          offset: _textSlide.value * 20,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Clear visual direction.',
                                                  style: AppTypography.displayMedium(
                                                    color: AppColors.textPrimaryLight,
                                                    scale: scale,
                                                  ).copyWith(
                                                    fontSize: (isMobile ? 32 : 54) * scale,
                                                    height: 1.05,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'POSTERS · CAMPAIGN VISUALS · BRAND IDENTITIES · WORKSHOPS',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTypography.labelUppercase(
                                                  color: AppColors.textSecondaryLight,
                                                  scale: scale,
                                                ).copyWith(
                                                  fontSize: (isMobile ? 9.5 : 12) * scale,
                                                  letterSpacing: isMobile ? 1.0 : 2.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        // --- 3. BOTTOM FOOTER PROGRESS BAR ---
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.loadingMessage ?? 'Unfolding studio showcase...',
                                  style: AppTypography.bodySmall(
                                    color: AppColors.textMutedLight,
                                    scale: scale,
                                  ).copyWith(fontSize: 12 * scale),
                                ),
                                Text(
                                  'VOL. 2026',
                                  style: AppTypography.labelMonoSmall(
                                    color: AppColors.textMutedLight,
                                    scale: scale,
                                  ).copyWith(fontSize: 11 * scale),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Fullwidth Minimal Progress Track
                            AnimatedBuilder(
                              animation: _counterController,
                              builder: (context, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 3.0,
                                        width: double.infinity,
                                        color: AppColors.surfaceSubtleLight,
                                      ),
                                      FractionallySizedBox(
                                        widthFactor: _counterProgress.value,
                                        child: Container(
                                          height: 3.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.posterClay,
                                                AppColors.textPrimaryLight,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Compact Studio Loader for inline loading states.
class StudioInlineLoader extends StatefulWidget {
  final double size;
  final Color? color;

  const StudioInlineLoader({
    super.key,
    this.size = 24.0,
    this.color,
  });

  @override
  State<StudioInlineLoader> createState() => _StudioInlineLoaderState();
}

class _StudioInlineLoaderState extends State<StudioInlineLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strokeColor = widget.color ?? AppColors.textPrimaryLight;

    return RotationTransition(
      turns: _controller,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(strokeColor),
          backgroundColor: strokeColor.withValues(alpha: 0.15),
        ),
      ),
    );
  }
}

/// Minimalist Card Loader for placeholder states.
class StudioCardLoader extends StatelessWidget {
  final double height;
  final String label;

  const StudioCardLoader({
    super.key,
    this.height = 200.0,
    this.label = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surfaceSubtleLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StudioInlineLoader(size: 24),
            const SizedBox(height: 12),
            Text(
              label,
              style: AppTypography.bodySmall(
                color: AppColors.textMutedLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
