import 'package:flutter/material.dart';

/// Centralized Studio Proof Color Tokens
class AppColors {
  // Primary Palette (Crisp High-Contrast Minimalist White & Black)
  static const Color bgLight = Color(0xFFFFFFFF);
  static const Color bgDark = Color(0xFFFFFFFF);
  
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color surfaceDark = Color(0xFFFAFAFA);
  
  static const Color surfaceSubtleLight = Color(0xFFF3F4F6);
  static const Color surfaceSubtleDark = Color(0xFFF3F4F6);

  // Typography Colors (Crisp Black Secondary Font Color)
  static const Color textPrimaryLight = Color(0xFF0A0A0A);
  static const Color textPrimaryDark = Color(0xFF0A0A0A);

  static const Color textSecondaryLight = Color(0xFF374151);
  static const Color textSecondaryDark = Color(0xFF374151);

  static const Color textMutedLight = Color(0xFF6B7280);
  static const Color textMutedDark = Color(0xFF6B7280);

  // Borders & Dividers
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFFE2E8F0);

  static const Color borderHoverLight = Color(0xFF0A0A0A);
  static const Color borderHoverDark = Color(0xFF0A0A0A);

  // Signature Accent (Bold Black & Terracotta)
  static const Color accent = Color(0xFF0A0A0A);
  static const Color accentLight = Color(0xFFF8FAFC);
  static const Color accentDark = Color(0xFF0A0A0A);

  // Glassmorphic & Card Surface Fills
  static const Color surfaceGlassDark = Color(0xF7FFFFFF); // Clean white card
  static const Color surfaceGlassLight = Color(0xF7FFFFFF); // Clean white card
  static const Color borderGlassDark = Color(0x1F000000);
  static const Color borderGlassLight = Color(0x1F000000);

  // Gradients & Glow Effects
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF0A0A0A), Color(0xFF1E293B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradientDark = LinearGradient(
    colors: [Color(0x08000000), Color(0x02000000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<BoxShadow> glowAccent = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 24,
      spreadRadius: -4,
      offset: Offset(0, 8),
    ),
  ];

  // Status Indicator Colors
  static const Color statusAvailable = Color(0xFF16A34A); // Green dot
  static const Color statusBusy = Color(0xFFEA580C); // Amber dot

  // Secondary Accents for Poster Visuals
  static const Color posterAmber = Color(0xFFD97706);
  static const Color posterCobalt = Color(0xFF2563EB);
  static const Color posterOlive = Color(0xFF15803D);
  static const Color posterPlum = Color(0xFF7E22CE);
  static const Color posterClay = Color(0xFFC2410C);

  // Studio Loader Palette (Matching StudioProof Crisp White & Black Studio aesthetic)
  static const Color loaderBg = Color(0xFFFFFFFF); // Crisp pure white background
  static const Color loaderSurface = Color(0xFFFAFAFA); // Studio surface card
  static const Color loaderAccent = Color(0xFFC2410C); // Terracotta clay accent
  static const Color loaderGlow = Color(0xFFF7EFEA); // Soft warm studio terracotta ambient sheen
  static const Color loaderBorder = Color(0xFFE2E8F0); // Delicate border matching studio cards
}


