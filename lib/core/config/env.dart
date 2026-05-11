import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Typed access to environment variables.
///
/// Secrets are loaded from a `.env` file at app start. The `.env` file is
/// gitignored — never commit secrets. Use `.env.example` to document
/// required keys.
class Env {
  Env._();

  static String get supabaseUrl => _required('SUPABASE_URL');
  static String get supabaseAnonKey => _required('SUPABASE_ANON_KEY');
  static String get mapboxAccessToken => _required('MAPBOX_ACCESS_TOKEN');

  /// Optional: app environment (dev / staging / prod). Defaults to dev.
  static String get appEnv => dotenv.env['APP_ENV'] ?? 'dev';

  static bool get isProd => appEnv == 'prod';
  static bool get isDev => appEnv == 'dev';

  static String _required(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError(
        'Missing required env var: $key. '
        'Did you forget to copy .env.example to .env and fill it in?',
      );
    }
    return value;
  }
}
