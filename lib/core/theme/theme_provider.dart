import 'package:flutter/material.dart';

/// Centralized Theme Provider for manual Dark / Light / System theme switching.
class ThemeProvider extends ChangeNotifier {
  ThemeMode get themeMode => ThemeMode.light;

  bool isDarkMode(BuildContext context) {
    return false;
  }

  void toggleTheme(BuildContext context) {
    // Primary theme is White background & Black typography
  }

  void setThemeMode(ThemeMode mode) {
    // Primary theme is White background & Black typography
  }
}
