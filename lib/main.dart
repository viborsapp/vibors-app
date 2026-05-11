import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/supabase_client.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (.env at project root, bundled as asset).
  await dotenv.load(fileName: '.env');

  // Initialize Supabase (skipped if env vars aren't filled in — useful
  // when running just the UI without a backend yet).
  await _maybeInitSupabase();

  // Lock portrait orientation for now (the social/check-in UX is
  // designed portrait-first; landscape would be a Phase-2 consideration).
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Edge-to-edge with translucent status & nav bars.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const ProviderScope(child: ViborsApp()));
}

Future<void> _maybeInitSupabase() async {
  try {
    await SupabaseConfig.initialize();
  } on StateError catch (e) {
    // Allow scaffold to boot without backend — useful while we set things up.
    debugPrint('[Vibors] Supabase init skipped: $e');
  }
}

class ViborsApp extends StatelessWidget {
  const ViborsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Vibors',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('ar', 'AE'),
        Locale('en', 'US'),
      ],
    );
  }
}
