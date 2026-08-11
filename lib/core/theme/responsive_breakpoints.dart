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
      return 20.0;
    } else if (width <= tabletMax) {
      return 32.0;
    } else if (width <= 1440) {
      return 64.0;
    } else {
      return (width - maxContentWidth) / 2;
    }
  }

  /// Adaptive Font Scale Factor for device typography
  static double getTypographyScale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= mobileMax) {
      return 0.84;
    } else if (width <= tabletMax) {
      return 0.92;
    } else {
      return 1.0;
    }
  }
}
