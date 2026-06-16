import 'package:flutter/material.dart';

/// Central theme for Mango.
///
/// Minimal, dark, utility-focused. Near-black surfaces, a single restrained
/// accent, high-contrast readable text, and generous tap targets.
class AppTheme {
  AppTheme._();

  // Core palette.
  static const Color _background = Color(0xFF0E0E10);
  static const Color _surface = Color(0xFF17171A);
  static const Color _surfaceVariant = Color(0xFF1F1F24);
  static const Color _accent = Color(0xFFE0654A); // warm "mango" accent
  static const Color _onSurface = Color(0xFFE8E8EA);
  static const Color _onSurfaceMuted = Color(0xFF9A9AA2);

  static ThemeData get dark {
    final colorScheme = const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: _accent,
      onPrimary: Colors.white,
      secondary: _accent,
      onSecondary: Colors.white,
      surface: _surface,
      onSurface: _onSurface,
      surfaceContainerHighest: _surfaceVariant,
      onSurfaceVariant: _onSurfaceMuted,
      error: Color(0xFFCF6679),
      onError: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _background,
      canvasColor: _background,
      appBarTheme: const AppBarTheme(
        backgroundColor: _background,
        foregroundColor: _onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        color: _surface,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: _onSurfaceMuted,
        textColor: _onSurface,
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF26262C),
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: _surfaceVariant,
        contentTextStyle: TextStyle(color: _onSurface),
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _accent,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
