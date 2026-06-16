import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference.freezed.dart';
part 'reference.g.dart';

/// Mirrors the shape of `reference.json`: a top-level array of manga, each with
/// a list of chapters, each with an ordered list of page URLs.
@freezed
abstract class ReferenceManga with _$ReferenceManga {
  const factory ReferenceManga({
    required String title,
    required String identifier,
    required String thumbnail,
    @Default(<ReferenceChapter>[]) List<ReferenceChapter> chapters,
  }) = _ReferenceManga;

  factory ReferenceManga.fromJson(Map<String, dynamic> json) =>
      _$ReferenceMangaFromJson(json);
}

@freezed
abstract class ReferenceChapter with _$ReferenceChapter {
  const factory ReferenceChapter({
    required String id,
    required int order,
    @Default(<String>[]) List<String> pages,
  }) = _ReferenceChapter;

  factory ReferenceChapter.fromJson(Map<String, dynamic> json) =>
      _$ReferenceChapterFromJson(json);
}

/// Thrown when a reference document cannot be parsed into the expected shape.
class ReferenceParseException implements Exception {
  ReferenceParseException(this.message);
  final String message;
  @override
  String toString() => 'ReferenceParseException: $message';
}

/// Parses a reference document (the contents of `reference.json` or pasted
/// JSON) into a list of [ReferenceManga].
///
/// Accepts either a top-level array of manga, or a single manga object.
List<ReferenceManga> parseReferenceJson(String source) {
  final dynamic decoded;
  try {
    decoded = jsonDecode(source);
  } on FormatException catch (e) {
    throw ReferenceParseException('Invalid JSON: ${e.message}');
  }

  try {
    if (decoded is List) {
      return decoded
          .cast<Map<String, dynamic>>()
          .map(ReferenceManga.fromJson)
          .toList(growable: false);
    }
    if (decoded is Map<String, dynamic>) {
      return [ReferenceManga.fromJson(decoded)];
    }
  } on Object catch (e) {
    throw ReferenceParseException('Unexpected reference structure: $e');
  }

  throw ReferenceParseException(
    'Expected a JSON array or object, got ${decoded.runtimeType}.',
  );
}
