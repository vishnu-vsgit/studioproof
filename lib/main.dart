import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'core/config/app_config.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'routes/app_router.dart';

void main() async {
  // Use clean URL path strategy without '#' in Flutter Web
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  runApp(const StudioProofApp());
}

class StudioProofApp extends StatelessWidget {
  const StudioProofApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: AppConfig.studioName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.lightTheme,
            themeMode: ThemeMode.light,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
