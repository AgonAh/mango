// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReferenceManga _$ReferenceMangaFromJson(
  Map<String, dynamic> json,
) => _ReferenceManga(
  title: json['title'] as String,
  identifier: json['identifier'] as String,
  thumbnail: json['thumbnail'] as String,
  progress: json['progress'] == null
      ? null
      : ReferenceProgress.fromJson(json['progress'] as Map<String, dynamic>),
  favoritePages:
      (json['favoritePages'] as List<dynamic>?)
          ?.map((e) => ReferenceProgress.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReferenceProgress>[],
  chapters:
      (json['chapters'] as List<dynamic>?)
          ?.map((e) => ReferenceChapter.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReferenceChapter>[],
);

Map<String, dynamic> _$ReferenceMangaToJson(_ReferenceManga instance) =>
    <String, dynamic>{
      'title': instance.title,
      'identifier': instance.identifier,
      'thumbnail': instance.thumbnail,
      'progress': instance.progress,
      'favoritePages': instance.favoritePages,
      'chapters': instance.chapters,
    };

_ReferenceProgress _$ReferenceProgressFromJson(Map<String, dynamic> json) =>
    _ReferenceProgress(
      chapter: json['chapter'] as String,
      page: (json['page'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$ReferenceProgressToJson(_ReferenceProgress instance) =>
    <String, dynamic>{'chapter': instance.chapter, 'page': instance.page};

_ReferenceChapter _$ReferenceChapterFromJson(Map<String, dynamic> json) =>
    _ReferenceChapter(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      title: json['title'] as String?,
      pages:
          (json['pages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ReferenceChapterToJson(_ReferenceChapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'title': instance.title,
      'pages': instance.pages,
    };
