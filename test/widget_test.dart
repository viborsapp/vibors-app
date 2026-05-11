// Smoke test — verifies the splash screen renders.
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vibors_app/main.dart';

void main() {
  setUpAll(() async {
    // Load env (placeholder values are fine for widget tests).
    dotenv.testLoad(fileInput: '''
SUPABASE_URL=https://test.supabase.co
SUPABASE_ANON_KEY=test
MAPBOX_ACCESS_TOKEN=pk.test
APP_ENV=dev
''');
  });

  testWidgets('Splash renders Vibors wordmark', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ViborsApp()));
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text('VIBORS'), findsOneWidget);
  });
}
