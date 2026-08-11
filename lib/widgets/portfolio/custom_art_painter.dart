import 'package:flutter/material.dart';

/// Art-Directed Canvas Painters for Studio Proof Case Study Artwork
class CustomArtPainter extends CustomPainter {
  final String style;
  final bool isDarkTheme;

  CustomArtPainter({required this.style, this.isDarkTheme = false});

  @override
  void paint(Canvas canvas, Size size) {
    switch (style) {
      case 'campus_fest':
        _paintCampusFest(canvas, size);
        break;
      case 'after_hours':
        _paintAfterHours(canvas, size);
        break;
      case 'launch_day':
        _paintLaunchDay(canvas, size);
        break;
      case 'sunday_market':
        _paintSundayMarket(canvas, size);
        break;
      case 'pulse_campaign':
        _paintPulseCampaign(canvas, size);
        break;
      case 'kinetix_studio':
        _paintKinetixStudio(canvas, size);
        break;
      default:
        _paintDefaultPoster(canvas, size);
    }
  }

  void _paintCampusFest(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF1B2430);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Terracotta Graphic Circle
    final accentPaint = Paint()..color = const Color(0xFFD94A26);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.35), size.width * 0.35, accentPaint);

    // Deep Amber Arch
    final amberPaint = Paint()..color = const Color(0xFFE68A2E);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.1, size.height * 0.5, size.width * 0.45, size.height * 0.4), amberPaint);

    // Grid Hairlines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (double i = 0; i <= size.width; i += size.width / 8) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double j = 0; j <= size.height; j += size.height / 8) {
      canvas.drawLine(Offset(0, j), Offset(size.width, j), gridPaint);
    }

    // Editorial Typography Accents
    _drawText(
      canvas,
      'CAMPUS \'26',
      Offset(size.width * 0.08, size.height * 0.12),
      fontSize: size.width * 0.09,
      color: const Color(0xFFFBF9F5),
      fontWeight: FontWeight.bold,
      letterSpacing: 4.0,
    );

    _drawText(
      canvas,
      'ANNUAL FESTIVAL / VISUAL IDENTITY',
      Offset(size.width * 0.08, size.height * 0.22),
      fontSize: size.width * 0.035,
      color: const Color(0xFFD94A26),
      letterSpacing: 2.0,
    );

    _drawText(
      canvas,
      'FEB 24 - 26 • MAIN ARENA',
      Offset(size.width * 0.12, size.height * 0.88),
      fontSize: size.width * 0.035,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,
    );
  }

  void _paintAfterHours(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF0D0D0D);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Halftone Waves / Lines
    final linePaint = Paint()
      ..color = const Color(0xFF262626)
      ..strokeWidth = 2.0;

    for (int i = 0; i < 24; i++) {
      double y = size.height * 0.15 + (i * size.height * 0.03);
      canvas.drawLine(Offset(size.width * 0.05, y), Offset(size.width * 0.95, y), linePaint);
    }

    // Amber Glow Block
    final amberPaint = Paint()..color = const Color(0xFFD94A26);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.55, size.height * 0.25, size.width * 0.35, size.height * 0.5), amberPaint);

    // Bold Title
    _drawText(
      canvas,
      'AFTER',
      Offset(size.width * 0.08, size.height * 0.28),
      fontSize: size.width * 0.12,
      color: const Color(0xFFF7F6F2),
      fontWeight: FontWeight.w900,
      letterSpacing: 6.0,
    );

    _drawText(
      canvas,
      'HOURS',
      Offset(size.width * 0.08, size.height * 0.42),
      fontSize: size.width * 0.12,
      color: const Color(0xFFD94A26),
      fontWeight: FontWeight.w900,
      letterSpacing: 6.0,
    );

    // Lineup Column
    _drawText(
      canvas,
      'LIVE SOUND • EXPERIMENTAL • SUBTERRANEAN',
      Offset(size.width * 0.08, size.height * 0.8),
      fontSize: size.width * 0.032,
      color: const Color(0xFFA5A39C),
      letterSpacing: 1.5,
    );
  }

  void _paintLaunchDay(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFF4F1EA);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Border Framing
    final borderPaint = Paint()
      ..color = const Color(0xFF111110)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.06, size.height * 0.06, size.width * 0.88, size.height * 0.88), borderPaint);

    // UI Window Box
    final boxPaint = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.14, size.height * 0.3, size.width * 0.72, size.height * 0.45), boxPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.14, size.height * 0.3, size.width * 0.72, size.height * 0.45), borderPaint);

    // Dot grid in window header
    final dotPaint = Paint()..color = const Color(0xFF111110);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.35), size.width * 0.012, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.24, size.height * 0.35), size.width * 0.012, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.28, size.height * 0.35), size.width * 0.012, dotPaint);

    _drawText(
      canvas,
      'LAUNCH DAY / V1.0',
      Offset(size.width * 0.12, size.height * 0.14),
      fontSize: size.width * 0.05,
      color: const Color(0xFF111110),
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    );

    _drawText(
      canvas,
      'STARTUP VISUAL SYSTEM',
      Offset(size.width * 0.12, size.height * 0.21),
      fontSize: size.width * 0.03,
      color: const Color(0xFFD94A26),
      letterSpacing: 1.5,
    );

    _drawText(
      canvas,
      'SYSTEM READY FOR SHIP',
      Offset(size.width * 0.2, size.height * 0.52),
      fontSize: size.width * 0.035,
      color: const Color(0xFF111110),
      fontWeight: FontWeight.w600,
    );
  }

  void _paintSundayMarket(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFF0ECE1);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Terracotta Tag Shape
    final tagPaint = Paint()..color = const Color(0xFF4A5D4E);
    final tagPath = Path()
      ..moveTo(size.width * 0.2, size.height * 0.15)
      ..lineTo(size.width * 0.8, size.height * 0.15)
      ..lineTo(size.width * 0.8, size.height * 0.85)
      ..lineTo(size.width * 0.2, size.height * 0.85)
      ..close();
    canvas.drawPath(tagPath, tagPaint);

    // Inner Cream Box
    final innerPaint = Paint()..color = const Color(0xFFFBF9F5);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.25, size.height * 0.2, size.width * 0.5, size.height * 0.65), innerPaint);

    _drawText(
      canvas,
      'SUNDAY',
      Offset(size.width * 0.3, size.height * 0.3),
      fontSize: size.width * 0.07,
      color: const Color(0xFF111110),
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    );

    _drawText(
      canvas,
      'MARKET',
      Offset(size.width * 0.3, size.height * 0.4),
      fontSize: size.width * 0.07,
      color: const Color(0xFF4A5D4E),
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
    );

    _drawText(
      canvas,
      'ARTISAN COLLECTIVE • NO. 04',
      Offset(size.width * 0.3, size.height * 0.72),
      fontSize: size.width * 0.025,
      color: const Color(0xFF666460),
      letterSpacing: 1.0,
    );
  }

  void _paintPulseCampaign(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF6B3A5A);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Warm Clay Arch
    final clayPaint = Paint()..color = const Color(0xFFE68A2E);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.6), size.width * 0.3, clayPaint);

    _drawText(
      canvas,
      'PULSE',
      Offset(size.width * 0.1, size.height * 0.15),
      fontSize: size.width * 0.1,
      color: const Color(0xFFFBF9F5),
      fontWeight: FontWeight.w900,
      letterSpacing: 4.0,
    );

    _drawText(
      canvas,
      'AWARENESS CAMPAIGN',
      Offset(size.width * 0.1, size.height * 0.28),
      fontSize: size.width * 0.035,
      color: const Color(0xFFFBF9F5),
      letterSpacing: 2.0,
    );

    _drawText(
      canvas,
      '"YOUR VOICE MATTERS."',
      Offset(size.width * 0.35, size.height * 0.58),
      fontSize: size.width * 0.045,
      color: const Color(0xFF111110),
      fontWeight: FontWeight.bold,
    );
  }

  void _paintKinetixStudio(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF111110);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final linePaint = Paint()
      ..color = const Color(0xFFD94A26)
      ..strokeWidth = 3.0;

    for (int i = 0; i < 6; i++) {
      double offset = i * size.width * 0.12;
      canvas.drawLine(Offset(offset, size.height * 0.1), Offset(offset + size.width * 0.3, size.height * 0.9), linePaint);
    }

    _drawText(
      canvas,
      'KINETIX',
      Offset(size.width * 0.1, size.height * 0.35),
      fontSize: size.width * 0.09,
      color: const Color(0xFFFBF9F5),
      fontWeight: FontWeight.bold,
      letterSpacing: 6.0,
    );

    _drawText(
      canvas,
      'MOVEMENT SYSTEM',
      Offset(size.width * 0.1, size.height * 0.48),
      fontSize: size.width * 0.035,
      color: const Color(0xFFD94A26),
      letterSpacing: 3.0,
    );
  }

  void _paintDefaultPoster(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFF4F1EA);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final circlePaint = Paint()..color = const Color(0xFFD94A26);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.25, circlePaint);
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset position, {
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0.0,
  }) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        fontFamily: 'Plus Jakarta Sans',
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomArtPainter oldDelegate) {
    return oldDelegate.style != style || oldDelegate.isDarkTheme != isDarkTheme;
  }
}
