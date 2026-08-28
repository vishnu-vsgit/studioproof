import 'package:flutter/material.dart';

/// Centralized Theme Provider for manual Dark / Light / System theme switching.
class ThemeProvider extends ChangeNotifier {
  ThemeMode get themeMode => ThemeMode.dark;

  bool isDarkMode(BuildContext context) {
    return true;
  }

  void toggleTheme(BuildContext context) {
    // Theme is fixed to Dark Mode
  }

  void setThemeMode(ThemeMode mode) {
    // Theme is fixed to Dark Mode
  }
}
