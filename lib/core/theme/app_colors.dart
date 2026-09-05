import 'package:flutter/material.dart';

/// Centralized Studio Proof Color Tokens
class AppColors {
  // Primary Palette (Editorial Warm Restrained)
  static const Color bgLight = Color(0xFFFBF9F5);
  static const Color bgDark = Color(0xFF121210);
  
  static const Color surfaceLight = Color(0xFFF4F1EA);
  static const Color surfaceDark = Color(0xFF1B1B18);
  
  static const Color surfaceSubtleLight = Color(0xFFECE8DF);
  static const Color surfaceSubtleDark = Color(0xFF242420);

  // Typography Colors
  static const Color textPrimaryLight = Color(0xFF111110);
  static const Color textPrimaryDark = Color(0xFFF7F6F2);

  static const Color textSecondaryLight = Color(0xFF666460);
  static const Color textSecondaryDark = Color(0xFFA5A39C);

  static const Color textMutedLight = Color(0xFF94928B);
  static const Color textMutedDark = Color(0xFF706E67);

  // Borders & Dividers
  static const Color borderLight = Color(0xFFE5E2DA);
  static const Color borderDark = Color(0xFF2C2C27);

  static const Color borderHoverLight = Color(0xFF111110);
  static const Color borderHoverDark = Color(0xFFF7F6F2);

  // Signature Accent (Terracotta Vermillion)
  static const Color accent = Color(0xFFD94A26);
  static const Color accentLight = Color(0xFFFDF0ED);
  static const Color accentDark = Color(0xFF38150D);

  // Glassmorphic Surface Fills
  static const Color surfaceGlassDark = Color(0x991B1B18); // ~60% opacity
  static const Color surfaceGlassLight = Color(0xCCF4F1EA); // ~80% opacity
  static const Color borderGlassDark = Color(0x33FFFFFF);
  static const Color borderGlassLight = Color(0x22000000);

  // Gradients & Glow Effects
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFD94A26), Color(0xFFF27042)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradientDark = LinearGradient(
    colors: [Color(0x33FFFFFF), Color(0x05FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<BoxShadow> glowAccent = [
    BoxShadow(
      color: Color(0x40D94A26),
      blurRadius: 24,
      spreadRadius: -4,
      offset: Offset(0, 8),
    ),
  ];

  // Status Indicator Colors
  static const Color statusAvailable = Color(0xFF22C55E); // Green dot
  static const Color statusBusy = Color(0xFFF59E0B); // Amber dot

  // Secondary Accents for Poster Visuals
  static const Color posterAmber = Color(0xFFE68A2E);
  static const Color posterCobalt = Color(0xFF2B4C7E);
  static const Color posterOlive = Color(0xFF4A5D4E);
  static const Color posterPlum = Color(0xFF6B3A5A);
  static const Color posterClay = Color(0xFFC85A32);
}
