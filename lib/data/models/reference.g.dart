// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReferenceManga _$ReferenceMangaFromJson(Map<String, dynamic> json) =>
    _ReferenceManga(
      title: json['title'] as String,
      identifier: json['identifier'] as String,
      thumbnail: json['thumbnail'] as String,
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
      'chapters': instance.chapters,
    };

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
