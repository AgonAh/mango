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

 String get title; String get identifier; String get thumbnail; List<ReferenceChapter> get chapters;
/// Create a copy of ReferenceManga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceMangaCopyWith<ReferenceManga> get copyWith => _$ReferenceMangaCopyWithImpl<ReferenceManga>(this as ReferenceManga, _$identity);

  /// Serializes this ReferenceManga to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceManga&&(identical(other.title, title) || other.title == title)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other.chapters, chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,identifier,thumbnail,const DeepCollectionEquality().hash(chapters));

@override
String toString() {
  return 'ReferenceManga(title: $title, identifier: $identifier, thumbnail: $thumbnail, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $ReferenceMangaCopyWith<$Res>  {
  factory $ReferenceMangaCopyWith(ReferenceManga value, $Res Function(ReferenceManga) _then) = _$ReferenceMangaCopyWithImpl;
@useResult
$Res call({
 String title, String identifier, String thumbnail, List<ReferenceChapter> chapters
});




}
/// @nodoc
class _$ReferenceMangaCopyWithImpl<$Res>
    implements $ReferenceMangaCopyWith<$Res> {
  _$ReferenceMangaCopyWithImpl(this._self, this._then);

  final ReferenceManga _self;
  final $Res Function(ReferenceManga) _then;

/// Create a copy of ReferenceManga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? identifier = null,Object? thumbnail = null,Object? chapters = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ReferenceChapter>,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String identifier,  String thumbnail,  List<ReferenceChapter> chapters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReferenceManga() when $default != null:
return $default(_that.title,_that.identifier,_that.thumbnail,_that.chapters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String identifier,  String thumbnail,  List<ReferenceChapter> chapters)  $default,) {final _that = this;
switch (_that) {
case _ReferenceManga():
return $default(_that.title,_that.identifier,_that.thumbnail,_that.chapters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String identifier,  String thumbnail,  List<ReferenceChapter> chapters)?  $default,) {final _that = this;
switch (_that) {
case _ReferenceManga() when $default != null:
return $default(_that.title,_that.identifier,_that.thumbnail,_that.chapters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReferenceManga implements ReferenceManga {
  const _ReferenceManga({required this.title, required this.identifier, required this.thumbnail, final  List<ReferenceChapter> chapters = const <ReferenceChapter>[]}): _chapters = chapters;
  factory _ReferenceManga.fromJson(Map<String, dynamic> json) => _$ReferenceMangaFromJson(json);

@override final  String title;
@override final  String identifier;
@override final  String thumbnail;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferenceManga&&(identical(other.title, title) || other.title == title)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,identifier,thumbnail,const DeepCollectionEquality().hash(_chapters));

@override
String toString() {
  return 'ReferenceManga(title: $title, identifier: $identifier, thumbnail: $thumbnail, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$ReferenceMangaCopyWith<$Res> implements $ReferenceMangaCopyWith<$Res> {
  factory _$ReferenceMangaCopyWith(_ReferenceManga value, $Res Function(_ReferenceManga) _then) = __$ReferenceMangaCopyWithImpl;
@override @useResult
$Res call({
 String title, String identifier, String thumbnail, List<ReferenceChapter> chapters
});




}
/// @nodoc
class __$ReferenceMangaCopyWithImpl<$Res>
    implements _$ReferenceMangaCopyWith<$Res> {
  __$ReferenceMangaCopyWithImpl(this._self, this._then);

  final _ReferenceManga _self;
  final $Res Function(_ReferenceManga) _then;

/// Create a copy of ReferenceManga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? identifier = null,Object? thumbnail = null,Object? chapters = null,}) {
  return _then(_ReferenceManga(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ReferenceChapter>,
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
