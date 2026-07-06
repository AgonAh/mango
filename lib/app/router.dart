import 'package:flutter/material.dart';

import '../features/books/add_book_screen.dart';
import '../features/books/book_detail_screen.dart';
import '../features/books/book_reader_screen.dart';
import '../features/detail/detail_screen.dart';
import '../features/import/import_screen.dart';
import '../features/library/library_screen.dart';
import '../features/library/reorder_favorites_screen.dart';
import '../features/reader/favorites_reader_screen.dart';
import '../features/reader/reader_screen.dart';
import '../features/settings/export_screen.dart';
import '../features/settings/settings_screen.dart';

/// Named routes for the app. Kept deliberately simple (built-in Navigator)
/// for the MVP; can be swapped for go_router later if deep-linking is needed.
abstract class Routes {
  static const String library = '/';
  static const String import = '/import';
  static const String detail = '/detail';
  static const String reader = '/reader';
  static const String reorderFavorites = '/favorites/reorder';
  static const String favoritesReader = '/favorites/reader';
  static const String settings = '/settings';
  static const String export = '/export';
  static const String addBook = '/book/add';
  static const String bookDetail = '/book/detail';
  static const String bookReader = '/book/reader';
}

class AppRouter {
  const AppRouter();

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.library:
        return MaterialPageRoute(
          builder: (_) => const LibraryScreen(),
          settings: settings,
        );
      case Routes.import:
        return MaterialPageRoute(
          builder: (_) => const ImportScreen(),
          settings: settings,
        );
      case Routes.detail:
        final identifier = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(identifier: identifier),
          settings: settings,
        );
      case Routes.reader:
        final args = settings.arguments as ReaderArgs;
        return MaterialPageRoute(
          builder: (_) => ReaderScreen(args: args),
          settings: settings,
        );
      case Routes.reorderFavorites:
        return MaterialPageRoute(
          builder: (_) => const ReorderFavoritesScreen(),
          settings: settings,
        );
      case Routes.favoritesReader:
        final args = settings.arguments as FavoritesReaderArgs;
        return MaterialPageRoute(
          builder: (_) => FavoritesReaderScreen(args: args),
          settings: settings,
        );
      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );
      case Routes.export:
        return MaterialPageRoute(
          builder: (_) => const ExportScreen(),
          settings: settings,
        );
      case Routes.addBook:
        return MaterialPageRoute(
          builder: (_) => const AddBookScreen(),
          settings: settings,
        );
      case Routes.bookDetail:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BookDetailScreen(bookId: id),
          settings: settings,
        );
      case Routes.bookReader:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BookReaderScreen(bookId: id),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Unknown route: ${settings.name}')),
          ),
          settings: settings,
        );
    }
  }
}
