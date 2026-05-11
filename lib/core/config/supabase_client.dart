import 'package:supabase_flutter/supabase_flutter.dart';

import 'env.dart';

/// Initialise Supabase once at app start.
///
/// After init, access the client anywhere via `Supabase.instance.client`.
class SupabaseConfig {
  SupabaseConfig._();

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
      debug: Env.isDev,
    );
  }

  /// Shortcut to the Supabase client.
  static SupabaseClient get client => Supabase.instance.client;
}
