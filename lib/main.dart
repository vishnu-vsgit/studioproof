import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

void main() {
  // Use clean URL path strategy without '#' in Flutter Web
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StudioProofApp());
}

class StudioProofApp extends StatelessWidget {
  const StudioProofApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StudioProof | Independent Graphic Design Studio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
