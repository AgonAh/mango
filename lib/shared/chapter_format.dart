import '../data/db/database.dart';

/// Display name for a chapter: its JSON `title` when present, otherwise a
/// "Chapter <id>" fallback built from the source id.
String chapterName(ChapterRow chapter) {
  final title = chapter.title?.trim();
  if (title != null && title.isNotEmpty) return title;
  return 'Chapter ${chapter.sourceChapterId}';
}
