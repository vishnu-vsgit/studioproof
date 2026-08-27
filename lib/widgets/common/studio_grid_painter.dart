import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Interactive Swiss-Style Grid Canvas Background Widget.
/// Renders crisp grid guidelines, crosshairs, alignment markers,
/// and subtle reactive cursor tracking for an authentic brutalist design studio aesthetic.
class StudioGridBackground extends StatefulWidget {
  final Widget child;
  final bool showCrosshairs;
  final bool enableMouseTracking;

  const StudioGridBackground({
    super.key,
    required this.child,
    this.showCrosshairs = true,
    this.enableMouseTracking = true,
  });

  @override
  State<StudioGridBackground> createState() => _StudioGridBackgroundState();
}

class _StudioGridBackgroundState extends State<StudioGridBackground> {
  Offset _mousePosition = Offset.zero;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onHover: widget.enableMouseTracking
          ? (event) {
              setState(() {
                _mousePosition = event.localPosition;
                _isHovering = true;
              });
            }
          : null,
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: CustomPaint(
        foregroundPainter: _StudioGridPainter(
          isDark: isDark,
          mousePosition: _mousePosition,
          isHovering: _isHovering,
          showCrosshairs: widget.showCrosshairs,
        ),
        child: widget.child,
      ),
    );
  }
}

class _StudioGridPainter extends CustomPainter {
  final bool isDark;
  final Offset mousePosition;
  final bool isHovering;
  final bool showCrosshairs;

  _StudioGridPainter({
    required this.isDark,
    required this.mousePosition,
    required this.isHovering,
    required this.showCrosshairs,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gridColor = isDark
        ? AppColors.borderDark.withValues(alpha: 0.35)
        : AppColors.borderLight.withValues(alpha: 0.45);

    final linePaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    final accentPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: isDark ? 0.35 : 0.25)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double gridSpacing = 48.0;

    // Draw Subtle Vertical & Horizontal Grid Guidelines
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // Draw Corner Alignment Crosshairs (Swiss Typography Grid Marks)
    const double crossSize = 6.0;
    final crossPositions = [
      const Offset(24, 24),
      Offset(size.width - 24, 24),
      Offset(24, size.height - 24),
      Offset(size.width - 24, size.height - 24),
    ];

    for (final pos in crossPositions) {
      canvas.drawLine(
        Offset(pos.dx - crossSize, pos.dy),
        Offset(pos.dx + crossSize, pos.dy),
        linePaint,
      );
      canvas.drawLine(
        Offset(pos.dx, pos.dy - crossSize),
        Offset(pos.dx, pos.dy + crossSize),
        linePaint,
      );
    }

    // Interactive Reactive Crosshair Tracking on Cursor Hover
    if (showCrosshairs && isHovering && mousePosition != Offset.zero) {
      // Horizontal Cursor Guideline
      canvas.drawLine(
        Offset(0, mousePosition.dy),
        Offset(size.width, mousePosition.dy),
        accentPaint,
      );
      // Vertical Cursor Guideline
      canvas.drawLine(
        Offset(mousePosition.dx, 0),
        Offset(mousePosition.dx, size.height),
        accentPaint,
      );

      // Subtle Center Circle Indicator
      final dotPaint = Paint()
        ..color = AppColors.accent.withValues(alpha: 0.8)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(mousePosition, 2.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _StudioGridPainter oldDelegate) {
    return oldDelegate.isDark != isDark ||
        oldDelegate.mousePosition != mousePosition ||
        oldDelegate.isHovering != isHovering ||
        oldDelegate.showCrosshairs != showCrosshairs;
  }
}
