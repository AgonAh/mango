import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/router.dart';
import 'app/theme.dart';
import 'data/services/settings_service.dart';
import 'shared/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = await SettingsService.create();
  runApp(
    ProviderScope(
      overrides: [settingsServiceProvider.overrideWithValue(settings)],
      child: const MangoApp(),
    ),
  );
}

class MangoApp extends StatelessWidget {
  const MangoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const router = AppRouter();
    return MaterialApp(
      title: 'Mango',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      initialRoute: Routes.library,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
