import 'package:flutter/material.dart';

/// Responsive Breakpoint and Layout Utilities for Cross-Device Alignment
class ResponsiveBreakpoints {
  static const double mobileMax = 767.0;
  static const double tabletMax = 1023.0;
  static const double maxContentWidth = 1360.0;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= mobileMax;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > mobileMax &&
      MediaQuery.of(context).size.width <= tabletMax;

  static bool isMobileOrTablet(BuildContext context) =>
      MediaQuery.of(context).size.width <= tabletMax;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > tabletMax;

  /// Adaptive Horizontal Padding based on device screen width
  static double getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= mobileMax) {
      return 18.0;
    } else if (width <= tabletMax) {
      return 36.0;
    } else {
      return 64.0;
    }
  }

  /// Adaptive Vertical Section Padding based on device screen width
  static double getVerticalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= mobileMax) {
      return 28.0;
    } else if (width <= tabletMax) {
      return 40.0;
    } else {
      return 64.0;
    }
  }

  /// Adaptive Font Scale Factor for device typography
  static double getTypographyScale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= mobileMax) {
      return 0.88;
    } else if (width <= tabletMax) {
      return 0.94;
    } else {
      return 1.0;
    }
  }
}
