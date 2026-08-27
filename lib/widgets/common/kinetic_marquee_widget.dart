import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/responsive_breakpoints.dart';

/// Kinetic Marquee Typography Widget.
/// Renders an infinite, smooth horizontal scrolling text banner with stroke outline / fill typography.
class KineticMarqueeWidget extends StatefulWidget {
  final String text;
  final bool reverse;
  final double speed; // Pixels per second
  final double fontSize;
  final bool isOutline;
  final double opacity;

  const KineticMarqueeWidget({
    super.key,
    required this.text,
    this.reverse = false,
    this.speed = 35.0,
    this.fontSize = 72.0,
    this.isOutline = true,
    this.opacity = 0.08,
  });

  @override
  State<KineticMarqueeWidget> createState() => _KineticMarqueeWidgetState();
}

class _KineticMarqueeWidgetState extends State<KineticMarqueeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scale = ResponsiveBreakpoints.getTypographyScale(context);
    final responsiveFontSize = widget.fontSize * scale;

    final baseColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    TextStyle textStyle;
    if (widget.isOutline) {
      textStyle = TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: responsiveFontSize,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = baseColor.withValues(alpha: widget.opacity),
      );
    } else {
      textStyle = TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: responsiveFontSize,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0,
        color: baseColor.withValues(alpha: widget.opacity),
      );
    }

    final repeatedText = '${widget.text} • ${widget.text} • ${widget.text} • ${widget.text} • ';

    return IgnorePointer(
      child: SizedBox(
        height: responsiveFontSize * 1.3,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final progress = widget.reverse ? (1.0 - _controller.value) : _controller.value;
            return FractionalTranslation(
              translation: Offset(-0.333 * progress, 0),
              child: OverflowBox(
                minWidth: 0,
                maxWidth: double.infinity,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(repeatedText, style: textStyle),
                    Text(repeatedText, style: textStyle),
                    Text(repeatedText, style: textStyle),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
