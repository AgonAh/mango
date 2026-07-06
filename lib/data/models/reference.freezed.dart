// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReferenceManga {

 String get title; String get identifier; String get thumbnail;// When [type] is 'pdf' or 'epub', this is a book: [url] points at the file
// (downloaded on first read). Absent [type] means a manga (uses chapters).
 String? get type; String? get url; String? get author; String? get series; ReferenceProgress? get progress; List<ReferenceProgress> get favoritePages; List<ReferenceChapter> get chapters;
/// Create a copy of ReferenceManga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceMangaCopyWith<ReferenceManga> get copyWith => _$ReferenceMangaCopyWithImpl<ReferenceManga>(this as ReferenceManga, _$identity);

  /// Serializes this ReferenceManga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceManga&&(identical(other.title, title) || other.title == title)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other.favoritePages, favoritePages)&&const DeepCollectionEquality().equals(other.chapters, chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,identifier,thumbnail,type,url,author,series,progress,const DeepCollectionEquality().hash(favoritePages),const DeepCollectionEquality().hash(chapters));

@override
String toString() {
  return 'ReferenceManga(title: $title, identifier: $identifier, thumbnail: $thumbnail, type: $type, url: $url, author: $author, series: $series, progress: $progress, favoritePages: $favoritePages, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $ReferenceMangaCopyWith<$Res>  {
  factory $ReferenceMangaCopyWith(ReferenceManga value, $Res Function(ReferenceManga) _then) = _$ReferenceMangaCopyWithImpl;
@useResult
$Res call({
 String title, String identifier, String thumbnail, String? type, String? url, String? author, String? series, ReferenceProgress? progress, List<ReferenceProgress> favoritePages, List<ReferenceChapter> chapters
});


$ReferenceProgressCopyWith<$Res>? get progress;

}
/// @nodoc
class _$ReferenceMangaCopyWithImpl<$Res>
    implements $ReferenceMangaCopyWith<$Res> {
  _$ReferenceMangaCopyWithImpl(this._self, this._then);

  final ReferenceManga _self;
  final $Res Function(ReferenceManga) _then;

/// Create a copy of ReferenceManga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? identifier = null,Object? thumbnail = null,Object? type = freezed,Object? url = freezed,Object? author = freezed,Object? series = freezed,Object? progress = freezed,Object? favoritePages = null,Object? chapters = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ReferenceProgress?,favoritePages: null == favoritePages ? _self.favoritePages : favoritePages // ignore: cast_nullable_to_non_nullable
as List<ReferenceProgress>,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ReferenceChapter>,
  ));
}
/// Create a copy of ReferenceManga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReferenceProgressCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $ReferenceProgressCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReferenceManga].
extension ReferenceMangaPatterns on ReferenceManga {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReferenceManga value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReferenceManga() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReferenceManga value)  $default,){
final _that = this;
switch (_that) {
case _ReferenceManga():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReferenceManga value)?  $default,){
final _that = this;
switch (_that) {
case _ReferenceManga() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String identifier,  String thumbnail,  String? type,  String? url,  String? author,  String? series,  ReferenceProgress? progress,  List<ReferenceProgress> favoritePages,  List<ReferenceChapter> chapters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReferenceManga() when $default != null:
return $default(_that.title,_that.identifier,_that.thumbnail,_that.type,_that.url,_that.author,_that.series,_that.progress,_that.favoritePages,_that.chapters);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String identifier,  String thumbnail,  String? type,  String? url,  String? author,  String? series,  ReferenceProgress? progress,  List<ReferenceProgress> favoritePages,  List<ReferenceChapter> chapters)  $default,) {final _that = this;
switch (_that) {
case _ReferenceManga():
return $default(_that.title,_that.identifier,_that.thumbnail,_that.type,_that.url,_that.author,_that.series,_that.progress,_that.favoritePages,_that.chapters);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String identifier,  String thumbnail,  String? type,  String? url,  String? author,  String? series,  ReferenceProgress? progress,  List<ReferenceProgress> favoritePages,  List<ReferenceChapter> chapters)?  $default,) {final _that = this;
switch (_that) {
case _ReferenceManga() when $default != null:
return $default(_that.title,_that.identifier,_that.thumbnail,_that.type,_that.url,_that.author,_that.series,_that.progress,_that.favoritePages,_that.chapters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReferenceManga implements ReferenceManga {
  const _ReferenceManga({required this.title, required this.identifier, required this.thumbnail, this.type, this.url, this.author, this.series, this.progress, final  List<ReferenceProgress> favoritePages = const <ReferenceProgress>[], final  List<ReferenceChapter> chapters = const <ReferenceChapter>[]}): _favoritePages = favoritePages,_chapters = chapters;
  factory _ReferenceManga.fromJson(Map<String, dynamic> json) => _$ReferenceMangaFromJson(json);

@override final  String title;
@override final  String identifier;
@override final  String thumbnail;
// When [type] is 'pdf' or 'epub', this is a book: [url] points at the file
// (downloaded on first read). Absent [type] means a manga (uses chapters).
@override final  String? type;
@override final  String? url;
@override final  String? author;
@override final  String? series;
@override final  ReferenceProgress? progress;
 final  List<ReferenceProgress> _favoritePages;
@override@JsonKey() List<ReferenceProgress> get favoritePages {
  if (_favoritePages is EqualUnmodifiableListView) return _favoritePages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoritePages);
}

 final  List<ReferenceChapter> _chapters;
@override@JsonKey() List<ReferenceChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}


/// Create a copy of ReferenceManga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferenceMangaCopyWith<_ReferenceManga> get copyWith => __$ReferenceMangaCopyWithImpl<_ReferenceManga>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceMangaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferenceManga&&(identical(other.title, title) || other.title == title)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.author, author) || other.author == author)&&(identical(other.series, series) || other.series == series)&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other._favoritePages, _favoritePages)&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,identifier,thumbnail,type,url,author,series,progress,const DeepCollectionEquality().hash(_favoritePages),const DeepCollectionEquality().hash(_chapters));

@override
String toString() {
  return 'ReferenceManga(title: $title, identifier: $identifier, thumbnail: $thumbnail, type: $type, url: $url, author: $author, series: $series, progress: $progress, favoritePages: $favoritePages, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$ReferenceMangaCopyWith<$Res> implements $ReferenceMangaCopyWith<$Res> {
  factory _$ReferenceMangaCopyWith(_ReferenceManga value, $Res Function(_ReferenceManga) _then) = __$ReferenceMangaCopyWithImpl;
@override @useResult
$Res call({
 String title, String identifier, String thumbnail, String? type, String? url, String? author, String? series, ReferenceProgress? progress, List<ReferenceProgress> favoritePages, List<ReferenceChapter> chapters
});


@override $ReferenceProgressCopyWith<$Res>? get progress;

}
/// @nodoc
class __$ReferenceMangaCopyWithImpl<$Res>
    implements _$ReferenceMangaCopyWith<$Res> {
  __$ReferenceMangaCopyWithImpl(this._self, this._then);

  final _ReferenceManga _self;
  final $Res Function(_ReferenceManga) _then;

/// Create a copy of ReferenceManga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? identifier = null,Object? thumbnail = null,Object? type = freezed,Object? url = freezed,Object? author = freezed,Object? series = freezed,Object? progress = freezed,Object? favoritePages = null,Object? chapters = null,}) {
  return _then(_ReferenceManga(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as ReferenceProgress?,favoritePages: null == favoritePages ? _self._favoritePages : favoritePages // ignore: cast_nullable_to_non_nullable
as List<ReferenceProgress>,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ReferenceChapter>,
  ));
}

/// Create a copy of ReferenceManga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReferenceProgressCopyWith<$Res>? get progress {
    if (_self.progress == null) {
    return null;
  }

  return $ReferenceProgressCopyWith<$Res>(_self.progress!, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// @nodoc
mixin _$ReferenceProgress {

 String get chapter; int get page;
/// Create a copy of ReferenceProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceProgressCopyWith<ReferenceProgress> get copyWith => _$ReferenceProgressCopyWithImpl<ReferenceProgress>(this as ReferenceProgress, _$identity);

  /// Serializes this ReferenceProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceProgress&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chapter,page);

@override
String toString() {
  return 'ReferenceProgress(chapter: $chapter, page: $page)';
}


}

/// @nodoc
abstract mixin class $ReferenceProgressCopyWith<$Res>  {
  factory $ReferenceProgressCopyWith(ReferenceProgress value, $Res Function(ReferenceProgress) _then) = _$ReferenceProgressCopyWithImpl;
@useResult
$Res call({
 String chapter, int page
});




}
/// @nodoc
class _$ReferenceProgressCopyWithImpl<$Res>
    implements $ReferenceProgressCopyWith<$Res> {
  _$ReferenceProgressCopyWithImpl(this._self, this._then);

  final ReferenceProgress _self;
  final $Res Function(ReferenceProgress) _then;

/// Create a copy of ReferenceProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chapter = null,Object? page = null,}) {
  return _then(_self.copyWith(
chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReferenceProgress].
extension ReferenceProgressPatterns on ReferenceProgress {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReferenceProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReferenceProgress() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReferenceProgress value)  $default,){
final _that = this;
switch (_that) {
case _ReferenceProgress():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReferenceProgress value)?  $default,){
final _that = this;
switch (_that) {
case _ReferenceProgress() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chapter,  int page)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReferenceProgress() when $default != null:
return $default(_that.chapter,_that.page);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chapter,  int page)  $default,) {final _that = this;
switch (_that) {
case _ReferenceProgress():
return $default(_that.chapter,_that.page);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chapter,  int page)?  $default,) {final _that = this;
switch (_that) {
case _ReferenceProgress() when $default != null:
return $default(_that.chapter,_that.page);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReferenceProgress implements ReferenceProgress {
  const _ReferenceProgress({required this.chapter, this.page = 1});
  factory _ReferenceProgress.fromJson(Map<String, dynamic> json) => _$ReferenceProgressFromJson(json);

@override final  String chapter;
@override@JsonKey() final  int page;

/// Create a copy of ReferenceProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferenceProgressCopyWith<_ReferenceProgress> get copyWith => __$ReferenceProgressCopyWithImpl<_ReferenceProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferenceProgress&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chapter,page);

@override
String toString() {
  return 'ReferenceProgress(chapter: $chapter, page: $page)';
}


}

/// @nodoc
abstract mixin class _$ReferenceProgressCopyWith<$Res> implements $ReferenceProgressCopyWith<$Res> {
  factory _$ReferenceProgressCopyWith(_ReferenceProgress value, $Res Function(_ReferenceProgress) _then) = __$ReferenceProgressCopyWithImpl;
@override @useResult
$Res call({
 String chapter, int page
});




}
/// @nodoc
class __$ReferenceProgressCopyWithImpl<$Res>
    implements _$ReferenceProgressCopyWith<$Res> {
  __$ReferenceProgressCopyWithImpl(this._self, this._then);

  final _ReferenceProgress _self;
  final $Res Function(_ReferenceProgress) _then;

/// Create a copy of ReferenceProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chapter = null,Object? page = null,}) {
  return _then(_ReferenceProgress(
chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReferenceChapter {

 String get id; int get order; String? get title; List<String> get pages;
/// Create a copy of ReferenceChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceChapterCopyWith<ReferenceChapter> get copyWith => _$ReferenceChapterCopyWithImpl<ReferenceChapter>(this as ReferenceChapter, _$identity);

  /// Serializes this ReferenceChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.pages, pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,order,title,const DeepCollectionEquality().hash(pages));

@override
String toString() {
  return 'ReferenceChapter(id: $id, order: $order, title: $title, pages: $pages)';
}


}

/// @nodoc
abstract mixin class $ReferenceChapterCopyWith<$Res>  {
  factory $ReferenceChapterCopyWith(ReferenceChapter value, $Res Function(ReferenceChapter) _then) = _$ReferenceChapterCopyWithImpl;
@useResult
$Res call({
 String id, int order, String? title, List<String> pages
});




}
/// @nodoc
class _$ReferenceChapterCopyWithImpl<$Res>
    implements $ReferenceChapterCopyWith<$Res> {
  _$ReferenceChapterCopyWithImpl(this._self, this._then);

  final ReferenceChapter _self;
  final $Res Function(ReferenceChapter) _then;

/// Create a copy of ReferenceChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? order = null,Object? title = freezed,Object? pages = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReferenceChapter].
extension ReferenceChapterPatterns on ReferenceChapter {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReferenceChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReferenceChapter() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReferenceChapter value)  $default,){
final _that = this;
switch (_that) {
case _ReferenceChapter():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReferenceChapter value)?  $default,){
final _that = this;
switch (_that) {
case _ReferenceChapter() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int order,  String? title,  List<String> pages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReferenceChapter() when $default != null:
return $default(_that.id,_that.order,_that.title,_that.pages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int order,  String? title,  List<String> pages)  $default,) {final _that = this;
switch (_that) {
case _ReferenceChapter():
return $default(_that.id,_that.order,_that.title,_that.pages);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int order,  String? title,  List<String> pages)?  $default,) {final _that = this;
switch (_that) {
case _ReferenceChapter() when $default != null:
return $default(_that.id,_that.order,_that.title,_that.pages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReferenceChapter implements ReferenceChapter {
  const _ReferenceChapter({required this.id, required this.order, this.title, final  List<String> pages = const <String>[]}): _pages = pages;
  factory _ReferenceChapter.fromJson(Map<String, dynamic> json) => _$ReferenceChapterFromJson(json);

@override final  String id;
@override final  int order;
@override final  String? title;
 final  List<String> _pages;
@override@JsonKey() List<String> get pages {
  if (_pages is EqualUnmodifiableListView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pages);
}


/// Create a copy of ReferenceChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferenceChapterCopyWith<_ReferenceChapter> get copyWith => __$ReferenceChapterCopyWithImpl<_ReferenceChapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferenceChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.order, order) || other.order == order)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._pages, _pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,order,title,const DeepCollectionEquality().hash(_pages));

@override
String toString() {
  return 'ReferenceChapter(id: $id, order: $order, title: $title, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$ReferenceChapterCopyWith<$Res> implements $ReferenceChapterCopyWith<$Res> {
  factory _$ReferenceChapterCopyWith(_ReferenceChapter value, $Res Function(_ReferenceChapter) _then) = __$ReferenceChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, int order, String? title, List<String> pages
});




}
/// @nodoc
class __$ReferenceChapterCopyWithImpl<$Res>
    implements _$ReferenceChapterCopyWith<$Res> {
  __$ReferenceChapterCopyWithImpl(this._self, this._then);

  final _ReferenceChapter _self;
  final $Res Function(_ReferenceChapter) _then;

/// Create a copy of ReferenceChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? order = null,Object? title = freezed,Object? pages = null,}) {
  return _then(_ReferenceChapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,pages: null == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
