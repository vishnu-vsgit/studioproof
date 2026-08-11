import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized Studio Proof Editorial Typography System
class AppTypography {
  // Display Serif Font (Editorial, Distinctive)
  static TextStyle displayLarge({Color color = AppColors.textPrimaryLight, double scale = 1.0}) {
    return GoogleFonts.instrumentSerif(
      fontSize: 84 * scale,
      height: 1.05,
      fontWeight: FontWeight.w400,
      color: color,
      letterSpacing: -1.0,
    );
  }

  static TextStyle displayMedium({Color color = AppColors.textPrimaryLight, double scale = 1.0}) {
    return GoogleFonts.instrumentSerif(
      fontSize: 56 * scale,
      height: 1.1,
      fontWeight: FontWeight.w400,
      color: color,
      letterSpacing: -0.5,
    );
  }

  static TextStyle displaySmall({Color color = AppColors.textPrimaryLight, double scale = 1.0}) {
    return GoogleFonts.instrumentSerif(
      fontSize: 40 * scale,
      height: 1.15,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle displayItalic({Color color = AppColors.textPrimaryLight, double scale = 1.0}) {
    return GoogleFonts.instrumentSerif(
      fontSize: 56 * scale,
      fontStyle: FontStyle.italic,
      height: 1.1,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  // Body & UI Font (Plus Jakarta Sans)
  static TextStyle heading1({Color color = AppColors.textPrimaryLight, double scale = 1.0}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 32 * scale,
      height: 1.25,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: -0.5,
    );
  }

  static TextStyle heading2({Color color = AppColors.textPrimaryLight, double scale = 1.0}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 24 * scale,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: -0.3,
    );
  }

  static TextStyle heading3({Color color = AppColors.textPrimaryLight, double scale = 1.0}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 20 * scale,
      height: 1.35,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle bodyLarge({Color color = AppColors.textSecondaryLight, double scale = 1.0}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 18 * scale,
      height: 1.6,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle bodyMedium({Color color = AppColors.textSecondaryLight, double scale = 1.0}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 15 * scale,
      height: 1.6,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle bodySmall({Color color = AppColors.textSecondaryLight, double scale = 1.0}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 13 * scale,
      height: 1.5,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  // Metadata / Label Badges (Uppercase Mono/Sans Editorial feel)
  static TextStyle labelUppercase({Color color = AppColors.textMutedLight, double scale = 1.0}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 12 * scale,
      height: 1.2,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,
      color: color,
    );
  }

  static TextStyle buttonText({Color color = AppColors.textPrimaryLight, double scale = 1.0}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 14 * scale,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      color: color,
    );
  }
}
