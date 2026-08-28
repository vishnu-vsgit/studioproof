import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/responsive_breakpoints.dart';

/// Swiss Studio Custom Cursor Follower Widget for Desktop Web.
/// Renders a smooth, subtle crosshair / ring cursor indicator that follows mouse motion.
class StudioCursorFollower extends StatefulWidget {
  final Widget child;
  final bool enableFollower;

  const StudioCursorFollower({
    super.key,
    required this.child,
    this.enableFollower = kIsWeb,
  });

  @override
  State<StudioCursorFollower> createState() => _StudioCursorFollowerState();
}

class _StudioCursorFollowerState extends State<StudioCursorFollower> {
  Offset _pointerPosition = Offset.zero;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobileOrTablet(context);
    if (!widget.enableFollower || isMobile) {
      return widget.child;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _pointerPosition = event.localPosition;
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: Stack(
        children: [
          widget.child,
          if (_isHovering && _pointerPosition != Offset.zero)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _SwissCursorPainter(
                    position: _pointerPosition,
                    isDark: isDark,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SwissCursorPainter extends CustomPainter {
  final Offset position;
  final bool isDark;

  _SwissCursorPainter({
    required this.position,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double radius = 16.0;
    const double innerRadius = 3.0;

    final outerRingPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: isDark ? 0.6 : 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final centerDotPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.fill;

    // Draw Outer Subtle Follower Ring
    canvas.drawCircle(position, radius, outerRingPaint);

    // Draw Center Precision Dot
    canvas.drawCircle(position, innerRadius, centerDotPaint);
  }

  @override
  bool shouldRepaint(covariant _SwissCursorPainter oldDelegate) {
    return oldDelegate.position != position || oldDelegate.isDark != isDark;
  }
}
