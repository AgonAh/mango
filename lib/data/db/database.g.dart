// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MangaTableTable extends MangaTable
    with TableInfo<$MangaTableTable, MangaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MangaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _identifierMeta = const VerificationMeta(
    'identifier',
  );
  @override
  late final GeneratedColumn<String> identifier = GeneratedColumn<String>(
    'identifier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailMeta = const VerificationMeta(
    'thumbnail',
  );
  @override
  late final GeneratedColumn<String> thumbnail = GeneratedColumn<String>(
    'thumbnail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _favoriteOrderMeta = const VerificationMeta(
    'favoriteOrder',
  );
  @override
  late final GeneratedColumn<int> favoriteOrder = GeneratedColumn<int>(
    'favorite_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReadChapterIdMeta = const VerificationMeta(
    'lastReadChapterId',
  );
  @override
  late final GeneratedColumn<int> lastReadChapterId = GeneratedColumn<int>(
    'last_read_chapter_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReadAtMeta = const VerificationMeta(
    'lastReadAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReadAt = GeneratedColumn<DateTime>(
    'last_read_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readingDirectionMeta = const VerificationMeta(
    'readingDirection',
  );
  @override
  late final GeneratedColumn<String> readingDirection = GeneratedColumn<String>(
    'reading_direction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    identifier,
    title,
    thumbnail,
    isFavorite,
    favoriteOrder,
    lastReadChapterId,
    lastReadAt,
    readingDirection,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'manga';
  @override
  VerificationContext validateIntegrity(
    Insertable<MangaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('identifier')) {
      context.handle(
        _identifierMeta,
        identifier.isAcceptableOrUnknown(data['identifier']!, _identifierMeta),
      );
    } else if (isInserting) {
      context.missing(_identifierMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(
        _thumbnailMeta,
        thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta),
      );
    } else if (isInserting) {
      context.missing(_thumbnailMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('favorite_order')) {
      context.handle(
        _favoriteOrderMeta,
        favoriteOrder.isAcceptableOrUnknown(
          data['favorite_order']!,
          _favoriteOrderMeta,
        ),
      );
    }
    if (data.containsKey('last_read_chapter_id')) {
      context.handle(
        _lastReadChapterIdMeta,
        lastReadChapterId.isAcceptableOrUnknown(
          data['last_read_chapter_id']!,
          _lastReadChapterIdMeta,
        ),
      );
    }
    if (data.containsKey('last_read_at')) {
      context.handle(
        _lastReadAtMeta,
        lastReadAt.isAcceptableOrUnknown(
          data['last_read_at']!,
          _lastReadAtMeta,
        ),
      );
    }
    if (data.containsKey('reading_direction')) {
      context.handle(
        _readingDirectionMeta,
        readingDirection.isAcceptableOrUnknown(
          data['reading_direction']!,
          _readingDirectionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {identifier};
  @override
  MangaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MangaRow(
      identifier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identifier'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      thumbnail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      favoriteOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}favorite_order'],
      ),
      lastReadChapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_read_chapter_id'],
      ),
      lastReadAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_read_at'],
      ),
      readingDirection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_direction'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MangaTableTable createAlias(String alias) {
    return $MangaTableTable(attachedDatabase, alias);
  }
}

class MangaRow extends DataClass implements Insertable<MangaRow> {
  final String identifier;
  final String title;
  final String thumbnail;
  final bool isFavorite;

  /// Manual sort position within favorites; null when not favorited.
  final int? favoriteOrder;

  /// Resume target: surrogate id of the last-opened chapter.
  final int? lastReadChapterId;

  /// Drives the "started reading sorts to top" rule.
  final DateTime? lastReadAt;

  /// Per-manga reading direction override: 'ltr', 'rtl', or null = follow the
  /// global default.
  final String? readingDirection;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MangaRow({
    required this.identifier,
    required this.title,
    required this.thumbnail,
    required this.isFavorite,
    this.favoriteOrder,
    this.lastReadChapterId,
    this.lastReadAt,
    this.readingDirection,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['identifier'] = Variable<String>(identifier);
    map['title'] = Variable<String>(title);
    map['thumbnail'] = Variable<String>(thumbnail);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || favoriteOrder != null) {
      map['favorite_order'] = Variable<int>(favoriteOrder);
    }
    if (!nullToAbsent || lastReadChapterId != null) {
      map['last_read_chapter_id'] = Variable<int>(lastReadChapterId);
    }
    if (!nullToAbsent || lastReadAt != null) {
      map['last_read_at'] = Variable<DateTime>(lastReadAt);
    }
    if (!nullToAbsent || readingDirection != null) {
      map['reading_direction'] = Variable<String>(readingDirection);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MangaTableCompanion toCompanion(bool nullToAbsent) {
    return MangaTableCompanion(
      identifier: Value(identifier),
      title: Value(title),
      thumbnail: Value(thumbnail),
      isFavorite: Value(isFavorite),
      favoriteOrder: favoriteOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(favoriteOrder),
      lastReadChapterId: lastReadChapterId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReadChapterId),
      lastReadAt: lastReadAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReadAt),
      readingDirection: readingDirection == null && nullToAbsent
          ? const Value.absent()
          : Value(readingDirection),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MangaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MangaRow(
      identifier: serializer.fromJson<String>(json['identifier']),
      title: serializer.fromJson<String>(json['title']),
      thumbnail: serializer.fromJson<String>(json['thumbnail']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      favoriteOrder: serializer.fromJson<int?>(json['favoriteOrder']),
      lastReadChapterId: serializer.fromJson<int?>(json['lastReadChapterId']),
      lastReadAt: serializer.fromJson<DateTime?>(json['lastReadAt']),
      readingDirection: serializer.fromJson<String?>(json['readingDirection']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'identifier': serializer.toJson<String>(identifier),
      'title': serializer.toJson<String>(title),
      'thumbnail': serializer.toJson<String>(thumbnail),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'favoriteOrder': serializer.toJson<int?>(favoriteOrder),
      'lastReadChapterId': serializer.toJson<int?>(lastReadChapterId),
      'lastReadAt': serializer.toJson<DateTime?>(lastReadAt),
      'readingDirection': serializer.toJson<String?>(readingDirection),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MangaRow copyWith({
    String? identifier,
    String? title,
    String? thumbnail,
    bool? isFavorite,
    Value<int?> favoriteOrder = const Value.absent(),
    Value<int?> lastReadChapterId = const Value.absent(),
    Value<DateTime?> lastReadAt = const Value.absent(),
    Value<String?> readingDirection = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MangaRow(
    identifier: identifier ?? this.identifier,
    title: title ?? this.title,
    thumbnail: thumbnail ?? this.thumbnail,
    isFavorite: isFavorite ?? this.isFavorite,
    favoriteOrder: favoriteOrder.present
        ? favoriteOrder.value
        : this.favoriteOrder,
    lastReadChapterId: lastReadChapterId.present
        ? lastReadChapterId.value
        : this.lastReadChapterId,
    lastReadAt: lastReadAt.present ? lastReadAt.value : this.lastReadAt,
    readingDirection: readingDirection.present
        ? readingDirection.value
        : this.readingDirection,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MangaRow copyWithCompanion(MangaTableCompanion data) {
    return MangaRow(
      identifier: data.identifier.present
          ? data.identifier.value
          : this.identifier,
      title: data.title.present ? data.title.value : this.title,
      thumbnail: data.thumbnail.present ? data.thumbnail.value : this.thumbnail,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      favoriteOrder: data.favoriteOrder.present
          ? data.favoriteOrder.value
          : this.favoriteOrder,
      lastReadChapterId: data.lastReadChapterId.present
          ? data.lastReadChapterId.value
          : this.lastReadChapterId,
      lastReadAt: data.lastReadAt.present
          ? data.lastReadAt.value
          : this.lastReadAt,
      readingDirection: data.readingDirection.present
          ? data.readingDirection.value
          : this.readingDirection,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MangaRow(')
          ..write('identifier: $identifier, ')
          ..write('title: $title, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('favoriteOrder: $favoriteOrder, ')
          ..write('lastReadChapterId: $lastReadChapterId, ')
          ..write('lastReadAt: $lastReadAt, ')
          ..write('readingDirection: $readingDirection, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    identifier,
    title,
    thumbnail,
    isFavorite,
    favoriteOrder,
    lastReadChapterId,
    lastReadAt,
    readingDirection,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MangaRow &&
          other.identifier == this.identifier &&
          other.title == this.title &&
          other.thumbnail == this.thumbnail &&
          other.isFavorite == this.isFavorite &&
          other.favoriteOrder == this.favoriteOrder &&
          other.lastReadChapterId == this.lastReadChapterId &&
          other.lastReadAt == this.lastReadAt &&
          other.readingDirection == this.readingDirection &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MangaTableCompanion extends UpdateCompanion<MangaRow> {
  final Value<String> identifier;
  final Value<String> title;
  final Value<String> thumbnail;
  final Value<bool> isFavorite;
  final Value<int?> favoriteOrder;
  final Value<int?> lastReadChapterId;
  final Value<DateTime?> lastReadAt;
  final Value<String?> readingDirection;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MangaTableCompanion({
    this.identifier = const Value.absent(),
    this.title = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.favoriteOrder = const Value.absent(),
    this.lastReadChapterId = const Value.absent(),
    this.lastReadAt = const Value.absent(),
    this.readingDirection = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MangaTableCompanion.insert({
    required String identifier,
    required String title,
    required String thumbnail,
    this.isFavorite = const Value.absent(),
    this.favoriteOrder = const Value.absent(),
    this.lastReadChapterId = const Value.absent(),
    this.lastReadAt = const Value.absent(),
    this.readingDirection = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : identifier = Value(identifier),
       title = Value(title),
       thumbnail = Value(thumbnail);
  static Insertable<MangaRow> custom({
    Expression<String>? identifier,
    Expression<String>? title,
    Expression<String>? thumbnail,
    Expression<bool>? isFavorite,
    Expression<int>? favoriteOrder,
    Expression<int>? lastReadChapterId,
    Expression<DateTime>? lastReadAt,
    Expression<String>? readingDirection,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (identifier != null) 'identifier': identifier,
      if (title != null) 'title': title,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (favoriteOrder != null) 'favorite_order': favoriteOrder,
      if (lastReadChapterId != null) 'last_read_chapter_id': lastReadChapterId,
      if (lastReadAt != null) 'last_read_at': lastReadAt,
      if (readingDirection != null) 'reading_direction': readingDirection,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MangaTableCompanion copyWith({
    Value<String>? identifier,
    Value<String>? title,
    Value<String>? thumbnail,
    Value<bool>? isFavorite,
    Value<int?>? favoriteOrder,
    Value<int?>? lastReadChapterId,
    Value<DateTime?>? lastReadAt,
    Value<String?>? readingDirection,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MangaTableCompanion(
      identifier: identifier ?? this.identifier,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteOrder: favoriteOrder ?? this.favoriteOrder,
      lastReadChapterId: lastReadChapterId ?? this.lastReadChapterId,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      readingDirection: readingDirection ?? this.readingDirection,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (identifier.present) {
      map['identifier'] = Variable<String>(identifier.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (favoriteOrder.present) {
      map['favorite_order'] = Variable<int>(favoriteOrder.value);
    }
    if (lastReadChapterId.present) {
      map['last_read_chapter_id'] = Variable<int>(lastReadChapterId.value);
    }
    if (lastReadAt.present) {
      map['last_read_at'] = Variable<DateTime>(lastReadAt.value);
    }
    if (readingDirection.present) {
      map['reading_direction'] = Variable<String>(readingDirection.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MangaTableCompanion(')
          ..write('identifier: $identifier, ')
          ..write('title: $title, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('favoriteOrder: $favoriteOrder, ')
          ..write('lastReadChapterId: $lastReadChapterId, ')
          ..write('lastReadAt: $lastReadAt, ')
          ..write('readingDirection: $readingDirection, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChapterTableTable extends ChapterTable
    with TableInfo<$ChapterTableTable, ChapterRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChapterTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mangaIdMeta = const VerificationMeta(
    'mangaId',
  );
  @override
  late final GeneratedColumn<String> mangaId = GeneratedColumn<String>(
    'manga_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES manga (identifier)',
    ),
  );
  static const VerificationMeta _sourceChapterIdMeta = const VerificationMeta(
    'sourceChapterId',
  );
  @override
  late final GeneratedColumn<String> sourceChapterId = GeneratedColumn<String>(
    'source_chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageCountMeta = const VerificationMeta(
    'pageCount',
  );
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
    'page_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDownloadedMeta = const VerificationMeta(
    'isDownloaded',
  );
  @override
  late final GeneratedColumn<bool> isDownloaded = GeneratedColumn<bool>(
    'is_downloaded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_downloaded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastPageReadMeta = const VerificationMeta(
    'lastPageRead',
  );
  @override
  late final GeneratedColumn<int> lastPageRead = GeneratedColumn<int>(
    'last_page_read',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _readUpdatedAtMeta = const VerificationMeta(
    'readUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> readUpdatedAt =
      GeneratedColumn<DateTime>(
        'read_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mangaId,
    sourceChapterId,
    title,
    sortOrder,
    pageCount,
    isDownloaded,
    lastPageRead,
    isRead,
    readUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChapterRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('manga_id')) {
      context.handle(
        _mangaIdMeta,
        mangaId.isAcceptableOrUnknown(data['manga_id']!, _mangaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mangaIdMeta);
    }
    if (data.containsKey('source_chapter_id')) {
      context.handle(
        _sourceChapterIdMeta,
        sourceChapterId.isAcceptableOrUnknown(
          data['source_chapter_id']!,
          _sourceChapterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceChapterIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('page_count')) {
      context.handle(
        _pageCountMeta,
        pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta),
      );
    }
    if (data.containsKey('is_downloaded')) {
      context.handle(
        _isDownloadedMeta,
        isDownloaded.isAcceptableOrUnknown(
          data['is_downloaded']!,
          _isDownloadedMeta,
        ),
      );
    }
    if (data.containsKey('last_page_read')) {
      context.handle(
        _lastPageReadMeta,
        lastPageRead.isAcceptableOrUnknown(
          data['last_page_read']!,
          _lastPageReadMeta,
        ),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('read_updated_at')) {
      context.handle(
        _readUpdatedAtMeta,
        readUpdatedAt.isAcceptableOrUnknown(
          data['read_updated_at']!,
          _readUpdatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {mangaId, sourceChapterId},
  ];
  @override
  ChapterRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChapterRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mangaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manga_id'],
      )!,
      sourceChapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_chapter_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      pageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_count'],
      )!,
      isDownloaded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_downloaded'],
      )!,
      lastPageRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_page_read'],
      ),
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      readUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}read_updated_at'],
      ),
    );
  }

  @override
  $ChapterTableTable createAlias(String alias) {
    return $ChapterTableTable(attachedDatabase, alias);
  }
}

class ChapterRow extends DataClass implements Insertable<ChapterRow> {
  final int id;
  final String mangaId;
  final String sourceChapterId;

  /// Optional display name from the JSON; falls back to the id when absent.
  final String? title;
  final int sortOrder;
  final int pageCount;
  final bool isDownloaded;

  /// Resume page within the chapter (0-based); null if never opened.
  final int? lastPageRead;
  final bool isRead;
  final DateTime? readUpdatedAt;
  const ChapterRow({
    required this.id,
    required this.mangaId,
    required this.sourceChapterId,
    this.title,
    required this.sortOrder,
    required this.pageCount,
    required this.isDownloaded,
    this.lastPageRead,
    required this.isRead,
    this.readUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['manga_id'] = Variable<String>(mangaId);
    map['source_chapter_id'] = Variable<String>(sourceChapterId);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['page_count'] = Variable<int>(pageCount);
    map['is_downloaded'] = Variable<bool>(isDownloaded);
    if (!nullToAbsent || lastPageRead != null) {
      map['last_page_read'] = Variable<int>(lastPageRead);
    }
    map['is_read'] = Variable<bool>(isRead);
    if (!nullToAbsent || readUpdatedAt != null) {
      map['read_updated_at'] = Variable<DateTime>(readUpdatedAt);
    }
    return map;
  }

  ChapterTableCompanion toCompanion(bool nullToAbsent) {
    return ChapterTableCompanion(
      id: Value(id),
      mangaId: Value(mangaId),
      sourceChapterId: Value(sourceChapterId),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      sortOrder: Value(sortOrder),
      pageCount: Value(pageCount),
      isDownloaded: Value(isDownloaded),
      lastPageRead: lastPageRead == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPageRead),
      isRead: Value(isRead),
      readUpdatedAt: readUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(readUpdatedAt),
    );
  }

  factory ChapterRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChapterRow(
      id: serializer.fromJson<int>(json['id']),
      mangaId: serializer.fromJson<String>(json['mangaId']),
      sourceChapterId: serializer.fromJson<String>(json['sourceChapterId']),
      title: serializer.fromJson<String?>(json['title']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      pageCount: serializer.fromJson<int>(json['pageCount']),
      isDownloaded: serializer.fromJson<bool>(json['isDownloaded']),
      lastPageRead: serializer.fromJson<int?>(json['lastPageRead']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      readUpdatedAt: serializer.fromJson<DateTime?>(json['readUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mangaId': serializer.toJson<String>(mangaId),
      'sourceChapterId': serializer.toJson<String>(sourceChapterId),
      'title': serializer.toJson<String?>(title),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'pageCount': serializer.toJson<int>(pageCount),
      'isDownloaded': serializer.toJson<bool>(isDownloaded),
      'lastPageRead': serializer.toJson<int?>(lastPageRead),
      'isRead': serializer.toJson<bool>(isRead),
      'readUpdatedAt': serializer.toJson<DateTime?>(readUpdatedAt),
    };
  }

  ChapterRow copyWith({
    int? id,
    String? mangaId,
    String? sourceChapterId,
    Value<String?> title = const Value.absent(),
    int? sortOrder,
    int? pageCount,
    bool? isDownloaded,
    Value<int?> lastPageRead = const Value.absent(),
    bool? isRead,
    Value<DateTime?> readUpdatedAt = const Value.absent(),
  }) => ChapterRow(
    id: id ?? this.id,
    mangaId: mangaId ?? this.mangaId,
    sourceChapterId: sourceChapterId ?? this.sourceChapterId,
    title: title.present ? title.value : this.title,
    sortOrder: sortOrder ?? this.sortOrder,
    pageCount: pageCount ?? this.pageCount,
    isDownloaded: isDownloaded ?? this.isDownloaded,
    lastPageRead: lastPageRead.present ? lastPageRead.value : this.lastPageRead,
    isRead: isRead ?? this.isRead,
    readUpdatedAt: readUpdatedAt.present
        ? readUpdatedAt.value
        : this.readUpdatedAt,
  );
  ChapterRow copyWithCompanion(ChapterTableCompanion data) {
    return ChapterRow(
      id: data.id.present ? data.id.value : this.id,
      mangaId: data.mangaId.present ? data.mangaId.value : this.mangaId,
      sourceChapterId: data.sourceChapterId.present
          ? data.sourceChapterId.value
          : this.sourceChapterId,
      title: data.title.present ? data.title.value : this.title,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      isDownloaded: data.isDownloaded.present
          ? data.isDownloaded.value
          : this.isDownloaded,
      lastPageRead: data.lastPageRead.present
          ? data.lastPageRead.value
          : this.lastPageRead,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      readUpdatedAt: data.readUpdatedAt.present
          ? data.readUpdatedAt.value
          : this.readUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChapterRow(')
          ..write('id: $id, ')
          ..write('mangaId: $mangaId, ')
          ..write('sourceChapterId: $sourceChapterId, ')
          ..write('title: $title, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('pageCount: $pageCount, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('lastPageRead: $lastPageRead, ')
          ..write('isRead: $isRead, ')
          ..write('readUpdatedAt: $readUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mangaId,
    sourceChapterId,
    title,
    sortOrder,
    pageCount,
    isDownloaded,
    lastPageRead,
    isRead,
    readUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChapterRow &&
          other.id == this.id &&
          other.mangaId == this.mangaId &&
          other.sourceChapterId == this.sourceChapterId &&
          other.title == this.title &&
          other.sortOrder == this.sortOrder &&
          other.pageCount == this.pageCount &&
          other.isDownloaded == this.isDownloaded &&
          other.lastPageRead == this.lastPageRead &&
          other.isRead == this.isRead &&
          other.readUpdatedAt == this.readUpdatedAt);
}

class ChapterTableCompanion extends UpdateCompanion<ChapterRow> {
  final Value<int> id;
  final Value<String> mangaId;
  final Value<String> sourceChapterId;
  final Value<String?> title;
  final Value<int> sortOrder;
  final Value<int> pageCount;
  final Value<bool> isDownloaded;
  final Value<int?> lastPageRead;
  final Value<bool> isRead;
  final Value<DateTime?> readUpdatedAt;
  const ChapterTableCompanion({
    this.id = const Value.absent(),
    this.mangaId = const Value.absent(),
    this.sourceChapterId = const Value.absent(),
    this.title = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    this.lastPageRead = const Value.absent(),
    this.isRead = const Value.absent(),
    this.readUpdatedAt = const Value.absent(),
  });
  ChapterTableCompanion.insert({
    this.id = const Value.absent(),
    required String mangaId,
    required String sourceChapterId,
    this.title = const Value.absent(),
    required int sortOrder,
    this.pageCount = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    this.lastPageRead = const Value.absent(),
    this.isRead = const Value.absent(),
    this.readUpdatedAt = const Value.absent(),
  }) : mangaId = Value(mangaId),
       sourceChapterId = Value(sourceChapterId),
       sortOrder = Value(sortOrder);
  static Insertable<ChapterRow> custom({
    Expression<int>? id,
    Expression<String>? mangaId,
    Expression<String>? sourceChapterId,
    Expression<String>? title,
    Expression<int>? sortOrder,
    Expression<int>? pageCount,
    Expression<bool>? isDownloaded,
    Expression<int>? lastPageRead,
    Expression<bool>? isRead,
    Expression<DateTime>? readUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mangaId != null) 'manga_id': mangaId,
      if (sourceChapterId != null) 'source_chapter_id': sourceChapterId,
      if (title != null) 'title': title,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (pageCount != null) 'page_count': pageCount,
      if (isDownloaded != null) 'is_downloaded': isDownloaded,
      if (lastPageRead != null) 'last_page_read': lastPageRead,
      if (isRead != null) 'is_read': isRead,
      if (readUpdatedAt != null) 'read_updated_at': readUpdatedAt,
    });
  }

  ChapterTableCompanion copyWith({
    Value<int>? id,
    Value<String>? mangaId,
    Value<String>? sourceChapterId,
    Value<String?>? title,
    Value<int>? sortOrder,
    Value<int>? pageCount,
    Value<bool>? isDownloaded,
    Value<int?>? lastPageRead,
    Value<bool>? isRead,
    Value<DateTime?>? readUpdatedAt,
  }) {
    return ChapterTableCompanion(
      id: id ?? this.id,
      mangaId: mangaId ?? this.mangaId,
      sourceChapterId: sourceChapterId ?? this.sourceChapterId,
      title: title ?? this.title,
      sortOrder: sortOrder ?? this.sortOrder,
      pageCount: pageCount ?? this.pageCount,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      lastPageRead: lastPageRead ?? this.lastPageRead,
      isRead: isRead ?? this.isRead,
      readUpdatedAt: readUpdatedAt ?? this.readUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mangaId.present) {
      map['manga_id'] = Variable<String>(mangaId.value);
    }
    if (sourceChapterId.present) {
      map['source_chapter_id'] = Variable<String>(sourceChapterId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (isDownloaded.present) {
      map['is_downloaded'] = Variable<bool>(isDownloaded.value);
    }
    if (lastPageRead.present) {
      map['last_page_read'] = Variable<int>(lastPageRead.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (readUpdatedAt.present) {
      map['read_updated_at'] = Variable<DateTime>(readUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChapterTableCompanion(')
          ..write('id: $id, ')
          ..write('mangaId: $mangaId, ')
          ..write('sourceChapterId: $sourceChapterId, ')
          ..write('title: $title, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('pageCount: $pageCount, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('lastPageRead: $lastPageRead, ')
          ..write('isRead: $isRead, ')
          ..write('readUpdatedAt: $readUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $PageTableTable extends PageTable
    with TableInfo<$PageTableTable, PageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id)',
    ),
  );
  static const VerificationMeta _pageIndexMeta = const VerificationMeta(
    'pageIndex',
  );
  @override
  late final GeneratedColumn<int> pageIndex = GeneratedColumn<int>(
    'page_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    chapterId,
    pageIndex,
    url,
    localPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pages';
  @override
  VerificationContext validateIntegrity(
    Insertable<PageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('page_index')) {
      context.handle(
        _pageIndexMeta,
        pageIndex.isAcceptableOrUnknown(data['page_index']!, _pageIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_pageIndexMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {chapterId, pageIndex},
  ];
  @override
  PageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_id'],
      )!,
      pageIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_index'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
    );
  }

  @override
  $PageTableTable createAlias(String alias) {
    return $PageTableTable(attachedDatabase, alias);
  }
}

class PageRow extends DataClass implements Insertable<PageRow> {
  final int id;
  final int chapterId;
  final int pageIndex;
  final String url;
  final String? localPath;
  const PageRow({
    required this.id,
    required this.chapterId,
    required this.pageIndex,
    required this.url,
    this.localPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chapter_id'] = Variable<int>(chapterId);
    map['page_index'] = Variable<int>(pageIndex);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    return map;
  }

  PageTableCompanion toCompanion(bool nullToAbsent) {
    return PageTableCompanion(
      id: Value(id),
      chapterId: Value(chapterId),
      pageIndex: Value(pageIndex),
      url: Value(url),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
    );
  }

  factory PageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PageRow(
      id: serializer.fromJson<int>(json['id']),
      chapterId: serializer.fromJson<int>(json['chapterId']),
      pageIndex: serializer.fromJson<int>(json['pageIndex']),
      url: serializer.fromJson<String>(json['url']),
      localPath: serializer.fromJson<String?>(json['localPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chapterId': serializer.toJson<int>(chapterId),
      'pageIndex': serializer.toJson<int>(pageIndex),
      'url': serializer.toJson<String>(url),
      'localPath': serializer.toJson<String?>(localPath),
    };
  }

  PageRow copyWith({
    int? id,
    int? chapterId,
    int? pageIndex,
    String? url,
    Value<String?> localPath = const Value.absent(),
  }) => PageRow(
    id: id ?? this.id,
    chapterId: chapterId ?? this.chapterId,
    pageIndex: pageIndex ?? this.pageIndex,
    url: url ?? this.url,
    localPath: localPath.present ? localPath.value : this.localPath,
  );
  PageRow copyWithCompanion(PageTableCompanion data) {
    return PageRow(
      id: data.id.present ? data.id.value : this.id,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      pageIndex: data.pageIndex.present ? data.pageIndex.value : this.pageIndex,
      url: data.url.present ? data.url.value : this.url,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PageRow(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('url: $url, ')
          ..write('localPath: $localPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, chapterId, pageIndex, url, localPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PageRow &&
          other.id == this.id &&
          other.chapterId == this.chapterId &&
          other.pageIndex == this.pageIndex &&
          other.url == this.url &&
          other.localPath == this.localPath);
}

class PageTableCompanion extends UpdateCompanion<PageRow> {
  final Value<int> id;
  final Value<int> chapterId;
  final Value<int> pageIndex;
  final Value<String> url;
  final Value<String?> localPath;
  const PageTableCompanion({
    this.id = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.pageIndex = const Value.absent(),
    this.url = const Value.absent(),
    this.localPath = const Value.absent(),
  });
  PageTableCompanion.insert({
    this.id = const Value.absent(),
    required int chapterId,
    required int pageIndex,
    required String url,
    this.localPath = const Value.absent(),
  }) : chapterId = Value(chapterId),
       pageIndex = Value(pageIndex),
       url = Value(url);
  static Insertable<PageRow> custom({
    Expression<int>? id,
    Expression<int>? chapterId,
    Expression<int>? pageIndex,
    Expression<String>? url,
    Expression<String>? localPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chapterId != null) 'chapter_id': chapterId,
      if (pageIndex != null) 'page_index': pageIndex,
      if (url != null) 'url': url,
      if (localPath != null) 'local_path': localPath,
    });
  }

  PageTableCompanion copyWith({
    Value<int>? id,
    Value<int>? chapterId,
    Value<int>? pageIndex,
    Value<String>? url,
    Value<String?>? localPath,
  }) {
    return PageTableCompanion(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      pageIndex: pageIndex ?? this.pageIndex,
      url: url ?? this.url,
      localPath: localPath ?? this.localPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<int>(chapterId.value);
    }
    if (pageIndex.present) {
      map['page_index'] = Variable<int>(pageIndex.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PageTableCompanion(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('url: $url, ')
          ..write('localPath: $localPath')
          ..write(')'))
        .toString();
  }
}

class $FavoritePageTableTable extends FavoritePageTable
    with TableInfo<$FavoritePageTableTable, FavoritePageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritePageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mangaIdMeta = const VerificationMeta(
    'mangaId',
  );
  @override
  late final GeneratedColumn<String> mangaId = GeneratedColumn<String>(
    'manga_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES manga (identifier)',
    ),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<int> chapterId = GeneratedColumn<int>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id)',
    ),
  );
  static const VerificationMeta _pageIndexMeta = const VerificationMeta(
    'pageIndex',
  );
  @override
  late final GeneratedColumn<int> pageIndex = GeneratedColumn<int>(
    'page_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mangaId,
    chapterId,
    pageIndex,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_pages';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoritePageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('manga_id')) {
      context.handle(
        _mangaIdMeta,
        mangaId.isAcceptableOrUnknown(data['manga_id']!, _mangaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mangaIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('page_index')) {
      context.handle(
        _pageIndexMeta,
        pageIndex.isAcceptableOrUnknown(data['page_index']!, _pageIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_pageIndexMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {chapterId, pageIndex},
  ];
  @override
  FavoritePageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoritePageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mangaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manga_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_id'],
      )!,
      pageIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_index'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritePageTableTable createAlias(String alias) {
    return $FavoritePageTableTable(attachedDatabase, alias);
  }
}

class FavoritePageRow extends DataClass implements Insertable<FavoritePageRow> {
  final int id;
  final String mangaId;
  final int chapterId;
  final int pageIndex;
  final DateTime createdAt;
  const FavoritePageRow({
    required this.id,
    required this.mangaId,
    required this.chapterId,
    required this.pageIndex,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['manga_id'] = Variable<String>(mangaId);
    map['chapter_id'] = Variable<int>(chapterId);
    map['page_index'] = Variable<int>(pageIndex);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritePageTableCompanion toCompanion(bool nullToAbsent) {
    return FavoritePageTableCompanion(
      id: Value(id),
      mangaId: Value(mangaId),
      chapterId: Value(chapterId),
      pageIndex: Value(pageIndex),
      createdAt: Value(createdAt),
    );
  }

  factory FavoritePageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritePageRow(
      id: serializer.fromJson<int>(json['id']),
      mangaId: serializer.fromJson<String>(json['mangaId']),
      chapterId: serializer.fromJson<int>(json['chapterId']),
      pageIndex: serializer.fromJson<int>(json['pageIndex']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mangaId': serializer.toJson<String>(mangaId),
      'chapterId': serializer.toJson<int>(chapterId),
      'pageIndex': serializer.toJson<int>(pageIndex),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoritePageRow copyWith({
    int? id,
    String? mangaId,
    int? chapterId,
    int? pageIndex,
    DateTime? createdAt,
  }) => FavoritePageRow(
    id: id ?? this.id,
    mangaId: mangaId ?? this.mangaId,
    chapterId: chapterId ?? this.chapterId,
    pageIndex: pageIndex ?? this.pageIndex,
    createdAt: createdAt ?? this.createdAt,
  );
  FavoritePageRow copyWithCompanion(FavoritePageTableCompanion data) {
    return FavoritePageRow(
      id: data.id.present ? data.id.value : this.id,
      mangaId: data.mangaId.present ? data.mangaId.value : this.mangaId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      pageIndex: data.pageIndex.present ? data.pageIndex.value : this.pageIndex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePageRow(')
          ..write('id: $id, ')
          ..write('mangaId: $mangaId, ')
          ..write('chapterId: $chapterId, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mangaId, chapterId, pageIndex, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePageRow &&
          other.id == this.id &&
          other.mangaId == this.mangaId &&
          other.chapterId == this.chapterId &&
          other.pageIndex == this.pageIndex &&
          other.createdAt == this.createdAt);
}

class FavoritePageTableCompanion extends UpdateCompanion<FavoritePageRow> {
  final Value<int> id;
  final Value<String> mangaId;
  final Value<int> chapterId;
  final Value<int> pageIndex;
  final Value<DateTime> createdAt;
  const FavoritePageTableCompanion({
    this.id = const Value.absent(),
    this.mangaId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.pageIndex = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoritePageTableCompanion.insert({
    this.id = const Value.absent(),
    required String mangaId,
    required int chapterId,
    required int pageIndex,
    this.createdAt = const Value.absent(),
  }) : mangaId = Value(mangaId),
       chapterId = Value(chapterId),
       pageIndex = Value(pageIndex);
  static Insertable<FavoritePageRow> custom({
    Expression<int>? id,
    Expression<String>? mangaId,
    Expression<int>? chapterId,
    Expression<int>? pageIndex,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mangaId != null) 'manga_id': mangaId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (pageIndex != null) 'page_index': pageIndex,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoritePageTableCompanion copyWith({
    Value<int>? id,
    Value<String>? mangaId,
    Value<int>? chapterId,
    Value<int>? pageIndex,
    Value<DateTime>? createdAt,
  }) {
    return FavoritePageTableCompanion(
      id: id ?? this.id,
      mangaId: mangaId ?? this.mangaId,
      chapterId: chapterId ?? this.chapterId,
      pageIndex: pageIndex ?? this.pageIndex,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mangaId.present) {
      map['manga_id'] = Variable<String>(mangaId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<int>(chapterId.value);
    }
    if (pageIndex.present) {
      map['page_index'] = Variable<int>(pageIndex.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePageTableCompanion(')
          ..write('id: $id, ')
          ..write('mangaId: $mangaId, ')
          ..write('chapterId: $chapterId, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MangaTableTable mangaTable = $MangaTableTable(this);
  late final $ChapterTableTable chapterTable = $ChapterTableTable(this);
  late final $PageTableTable pageTable = $PageTableTable(this);
  late final $FavoritePageTableTable favoritePageTable =
      $FavoritePageTableTable(this);
  late final MangaDao mangaDao = MangaDao(this as AppDatabase);
  late final ChapterDao chapterDao = ChapterDao(this as AppDatabase);
  late final PageDao pageDao = PageDao(this as AppDatabase);
  late final FavoritePageDao favoritePageDao = FavoritePageDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    mangaTable,
    chapterTable,
    pageTable,
    favoritePageTable,
  ];
}

typedef $$MangaTableTableCreateCompanionBuilder =
    MangaTableCompanion Function({
      required String identifier,
      required String title,
      required String thumbnail,
      Value<bool> isFavorite,
      Value<int?> favoriteOrder,
      Value<int?> lastReadChapterId,
      Value<DateTime?> lastReadAt,
      Value<String?> readingDirection,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$MangaTableTableUpdateCompanionBuilder =
    MangaTableCompanion Function({
      Value<String> identifier,
      Value<String> title,
      Value<String> thumbnail,
      Value<bool> isFavorite,
      Value<int?> favoriteOrder,
      Value<int?> lastReadChapterId,
      Value<DateTime?> lastReadAt,
      Value<String?> readingDirection,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$MangaTableTableReferences
    extends BaseReferences<_$AppDatabase, $MangaTableTable, MangaRow> {
  $$MangaTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChapterTableTable, List<ChapterRow>>
  _chapterTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.chapterTable,
    aliasName: $_aliasNameGenerator(
      db.mangaTable.identifier,
      db.chapterTable.mangaId,
    ),
  );

  $$ChapterTableTableProcessedTableManager get chapterTableRefs {
    final manager = $$ChapterTableTableTableManager($_db, $_db.chapterTable)
        .filter(
          (f) => f.mangaId.identifier.sqlEquals(
            $_itemColumn<String>('identifier')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_chapterTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoritePageTableTable, List<FavoritePageRow>>
  _favoritePageTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.favoritePageTable,
        aliasName: $_aliasNameGenerator(
          db.mangaTable.identifier,
          db.favoritePageTable.mangaId,
        ),
      );

  $$FavoritePageTableTableProcessedTableManager get favoritePageTableRefs {
    final manager =
        $$FavoritePageTableTableTableManager(
          $_db,
          $_db.favoritePageTable,
        ).filter(
          (f) => f.mangaId.identifier.sqlEquals(
            $_itemColumn<String>('identifier')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _favoritePageTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MangaTableTableFilterComposer
    extends Composer<_$AppDatabase, $MangaTableTable> {
  $$MangaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get identifier => $composableBuilder(
    column: $table.identifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get favoriteOrder => $composableBuilder(
    column: $table.favoriteOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastReadChapterId => $composableBuilder(
    column: $table.lastReadChapterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingDirection => $composableBuilder(
    column: $table.readingDirection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> chapterTableRefs(
    Expression<bool> Function($$ChapterTableTableFilterComposer f) f,
  ) {
    final $$ChapterTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.identifier,
      referencedTable: $db.chapterTable,
      getReferencedColumn: (t) => t.mangaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChapterTableTableFilterComposer(
            $db: $db,
            $table: $db.chapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoritePageTableRefs(
    Expression<bool> Function($$FavoritePageTableTableFilterComposer f) f,
  ) {
    final $$FavoritePageTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.identifier,
      referencedTable: $db.favoritePageTable,
      getReferencedColumn: (t) => t.mangaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritePageTableTableFilterComposer(
            $db: $db,
            $table: $db.favoritePageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MangaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MangaTableTable> {
  $$MangaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get identifier => $composableBuilder(
    column: $table.identifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get favoriteOrder => $composableBuilder(
    column: $table.favoriteOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastReadChapterId => $composableBuilder(
    column: $table.lastReadChapterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingDirection => $composableBuilder(
    column: $table.readingDirection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MangaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MangaTableTable> {
  $$MangaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get identifier => $composableBuilder(
    column: $table.identifier,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get thumbnail =>
      $composableBuilder(column: $table.thumbnail, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get favoriteOrder => $composableBuilder(
    column: $table.favoriteOrder,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastReadChapterId => $composableBuilder(
    column: $table.lastReadChapterId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readingDirection => $composableBuilder(
    column: $table.readingDirection,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> chapterTableRefs<T extends Object>(
    Expression<T> Function($$ChapterTableTableAnnotationComposer a) f,
  ) {
    final $$ChapterTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.identifier,
      referencedTable: $db.chapterTable,
      getReferencedColumn: (t) => t.mangaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChapterTableTableAnnotationComposer(
            $db: $db,
            $table: $db.chapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> favoritePageTableRefs<T extends Object>(
    Expression<T> Function($$FavoritePageTableTableAnnotationComposer a) f,
  ) {
    final $$FavoritePageTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.identifier,
          referencedTable: $db.favoritePageTable,
          getReferencedColumn: (t) => t.mangaId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FavoritePageTableTableAnnotationComposer(
                $db: $db,
                $table: $db.favoritePageTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MangaTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MangaTableTable,
          MangaRow,
          $$MangaTableTableFilterComposer,
          $$MangaTableTableOrderingComposer,
          $$MangaTableTableAnnotationComposer,
          $$MangaTableTableCreateCompanionBuilder,
          $$MangaTableTableUpdateCompanionBuilder,
          (MangaRow, $$MangaTableTableReferences),
          MangaRow,
          PrefetchHooks Function({
            bool chapterTableRefs,
            bool favoritePageTableRefs,
          })
        > {
  $$MangaTableTableTableManager(_$AppDatabase db, $MangaTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MangaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MangaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MangaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> identifier = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> thumbnail = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int?> favoriteOrder = const Value.absent(),
                Value<int?> lastReadChapterId = const Value.absent(),
                Value<DateTime?> lastReadAt = const Value.absent(),
                Value<String?> readingDirection = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MangaTableCompanion(
                identifier: identifier,
                title: title,
                thumbnail: thumbnail,
                isFavorite: isFavorite,
                favoriteOrder: favoriteOrder,
                lastReadChapterId: lastReadChapterId,
                lastReadAt: lastReadAt,
                readingDirection: readingDirection,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String identifier,
                required String title,
                required String thumbnail,
                Value<bool> isFavorite = const Value.absent(),
                Value<int?> favoriteOrder = const Value.absent(),
                Value<int?> lastReadChapterId = const Value.absent(),
                Value<DateTime?> lastReadAt = const Value.absent(),
                Value<String?> readingDirection = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MangaTableCompanion.insert(
                identifier: identifier,
                title: title,
                thumbnail: thumbnail,
                isFavorite: isFavorite,
                favoriteOrder: favoriteOrder,
                lastReadChapterId: lastReadChapterId,
                lastReadAt: lastReadAt,
                readingDirection: readingDirection,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MangaTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({chapterTableRefs = false, favoritePageTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (chapterTableRefs) db.chapterTable,
                    if (favoritePageTableRefs) db.favoritePageTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (chapterTableRefs)
                        await $_getPrefetchedData<
                          MangaRow,
                          $MangaTableTable,
                          ChapterRow
                        >(
                          currentTable: table,
                          referencedTable: $$MangaTableTableReferences
                              ._chapterTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MangaTableTableReferences(
                                db,
                                table,
                                p0,
                              ).chapterTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mangaId == item.identifier,
                              ),
                          typedResults: items,
                        ),
                      if (favoritePageTableRefs)
                        await $_getPrefetchedData<
                          MangaRow,
                          $MangaTableTable,
                          FavoritePageRow
                        >(
                          currentTable: table,
                          referencedTable: $$MangaTableTableReferences
                              ._favoritePageTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MangaTableTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritePageTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mangaId == item.identifier,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MangaTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MangaTableTable,
      MangaRow,
      $$MangaTableTableFilterComposer,
      $$MangaTableTableOrderingComposer,
      $$MangaTableTableAnnotationComposer,
      $$MangaTableTableCreateCompanionBuilder,
      $$MangaTableTableUpdateCompanionBuilder,
      (MangaRow, $$MangaTableTableReferences),
      MangaRow,
      PrefetchHooks Function({
        bool chapterTableRefs,
        bool favoritePageTableRefs,
      })
    >;
typedef $$ChapterTableTableCreateCompanionBuilder =
    ChapterTableCompanion Function({
      Value<int> id,
      required String mangaId,
      required String sourceChapterId,
      Value<String?> title,
      required int sortOrder,
      Value<int> pageCount,
      Value<bool> isDownloaded,
      Value<int?> lastPageRead,
      Value<bool> isRead,
      Value<DateTime?> readUpdatedAt,
    });
typedef $$ChapterTableTableUpdateCompanionBuilder =
    ChapterTableCompanion Function({
      Value<int> id,
      Value<String> mangaId,
      Value<String> sourceChapterId,
      Value<String?> title,
      Value<int> sortOrder,
      Value<int> pageCount,
      Value<bool> isDownloaded,
      Value<int?> lastPageRead,
      Value<bool> isRead,
      Value<DateTime?> readUpdatedAt,
    });

final class $$ChapterTableTableReferences
    extends BaseReferences<_$AppDatabase, $ChapterTableTable, ChapterRow> {
  $$ChapterTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MangaTableTable _mangaIdTable(_$AppDatabase db) =>
      db.mangaTable.createAlias(
        $_aliasNameGenerator(db.chapterTable.mangaId, db.mangaTable.identifier),
      );

  $$MangaTableTableProcessedTableManager get mangaId {
    final $_column = $_itemColumn<String>('manga_id')!;

    final manager = $$MangaTableTableTableManager(
      $_db,
      $_db.mangaTable,
    ).filter((f) => f.identifier.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mangaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PageTableTable, List<PageRow>>
  _pageTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pageTable,
    aliasName: $_aliasNameGenerator(db.chapterTable.id, db.pageTable.chapterId),
  );

  $$PageTableTableProcessedTableManager get pageTableRefs {
    final manager = $$PageTableTableTableManager(
      $_db,
      $_db.pageTable,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pageTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoritePageTableTable, List<FavoritePageRow>>
  _favoritePageTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.favoritePageTable,
        aliasName: $_aliasNameGenerator(
          db.chapterTable.id,
          db.favoritePageTable.chapterId,
        ),
      );

  $$FavoritePageTableTableProcessedTableManager get favoritePageTableRefs {
    final manager = $$FavoritePageTableTableTableManager(
      $_db,
      $_db.favoritePageTable,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _favoritePageTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChapterTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChapterTableTable> {
  $$ChapterTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceChapterId => $composableBuilder(
    column: $table.sourceChapterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastPageRead => $composableBuilder(
    column: $table.lastPageRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get readUpdatedAt => $composableBuilder(
    column: $table.readUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MangaTableTableFilterComposer get mangaId {
    final $$MangaTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mangaId,
      referencedTable: $db.mangaTable,
      getReferencedColumn: (t) => t.identifier,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MangaTableTableFilterComposer(
            $db: $db,
            $table: $db.mangaTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pageTableRefs(
    Expression<bool> Function($$PageTableTableFilterComposer f) f,
  ) {
    final $$PageTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pageTable,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PageTableTableFilterComposer(
            $db: $db,
            $table: $db.pageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoritePageTableRefs(
    Expression<bool> Function($$FavoritePageTableTableFilterComposer f) f,
  ) {
    final $$FavoritePageTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favoritePageTable,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritePageTableTableFilterComposer(
            $db: $db,
            $table: $db.favoritePageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChapterTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChapterTableTable> {
  $$ChapterTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceChapterId => $composableBuilder(
    column: $table.sourceChapterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastPageRead => $composableBuilder(
    column: $table.lastPageRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get readUpdatedAt => $composableBuilder(
    column: $table.readUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MangaTableTableOrderingComposer get mangaId {
    final $$MangaTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mangaId,
      referencedTable: $db.mangaTable,
      getReferencedColumn: (t) => t.identifier,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MangaTableTableOrderingComposer(
            $db: $db,
            $table: $db.mangaTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChapterTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChapterTableTable> {
  $$ChapterTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceChapterId => $composableBuilder(
    column: $table.sourceChapterId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<bool> get isDownloaded => $composableBuilder(
    column: $table.isDownloaded,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastPageRead => $composableBuilder(
    column: $table.lastPageRead,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<DateTime> get readUpdatedAt => $composableBuilder(
    column: $table.readUpdatedAt,
    builder: (column) => column,
  );

  $$MangaTableTableAnnotationComposer get mangaId {
    final $$MangaTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mangaId,
      referencedTable: $db.mangaTable,
      getReferencedColumn: (t) => t.identifier,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MangaTableTableAnnotationComposer(
            $db: $db,
            $table: $db.mangaTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pageTableRefs<T extends Object>(
    Expression<T> Function($$PageTableTableAnnotationComposer a) f,
  ) {
    final $$PageTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pageTable,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PageTableTableAnnotationComposer(
            $db: $db,
            $table: $db.pageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> favoritePageTableRefs<T extends Object>(
    Expression<T> Function($$FavoritePageTableTableAnnotationComposer a) f,
  ) {
    final $$FavoritePageTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.favoritePageTable,
          getReferencedColumn: (t) => t.chapterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FavoritePageTableTableAnnotationComposer(
                $db: $db,
                $table: $db.favoritePageTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ChapterTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChapterTableTable,
          ChapterRow,
          $$ChapterTableTableFilterComposer,
          $$ChapterTableTableOrderingComposer,
          $$ChapterTableTableAnnotationComposer,
          $$ChapterTableTableCreateCompanionBuilder,
          $$ChapterTableTableUpdateCompanionBuilder,
          (ChapterRow, $$ChapterTableTableReferences),
          ChapterRow,
          PrefetchHooks Function({
            bool mangaId,
            bool pageTableRefs,
            bool favoritePageTableRefs,
          })
        > {
  $$ChapterTableTableTableManager(_$AppDatabase db, $ChapterTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChapterTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChapterTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChapterTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> mangaId = const Value.absent(),
                Value<String> sourceChapterId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> pageCount = const Value.absent(),
                Value<bool> isDownloaded = const Value.absent(),
                Value<int?> lastPageRead = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime?> readUpdatedAt = const Value.absent(),
              }) => ChapterTableCompanion(
                id: id,
                mangaId: mangaId,
                sourceChapterId: sourceChapterId,
                title: title,
                sortOrder: sortOrder,
                pageCount: pageCount,
                isDownloaded: isDownloaded,
                lastPageRead: lastPageRead,
                isRead: isRead,
                readUpdatedAt: readUpdatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String mangaId,
                required String sourceChapterId,
                Value<String?> title = const Value.absent(),
                required int sortOrder,
                Value<int> pageCount = const Value.absent(),
                Value<bool> isDownloaded = const Value.absent(),
                Value<int?> lastPageRead = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime?> readUpdatedAt = const Value.absent(),
              }) => ChapterTableCompanion.insert(
                id: id,
                mangaId: mangaId,
                sourceChapterId: sourceChapterId,
                title: title,
                sortOrder: sortOrder,
                pageCount: pageCount,
                isDownloaded: isDownloaded,
                lastPageRead: lastPageRead,
                isRead: isRead,
                readUpdatedAt: readUpdatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChapterTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mangaId = false,
                pageTableRefs = false,
                favoritePageTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pageTableRefs) db.pageTable,
                    if (favoritePageTableRefs) db.favoritePageTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mangaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mangaId,
                                    referencedTable:
                                        $$ChapterTableTableReferences
                                            ._mangaIdTable(db),
                                    referencedColumn:
                                        $$ChapterTableTableReferences
                                            ._mangaIdTable(db)
                                            .identifier,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pageTableRefs)
                        await $_getPrefetchedData<
                          ChapterRow,
                          $ChapterTableTable,
                          PageRow
                        >(
                          currentTable: table,
                          referencedTable: $$ChapterTableTableReferences
                              ._pageTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChapterTableTableReferences(
                                db,
                                table,
                                p0,
                              ).pageTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chapterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (favoritePageTableRefs)
                        await $_getPrefetchedData<
                          ChapterRow,
                          $ChapterTableTable,
                          FavoritePageRow
                        >(
                          currentTable: table,
                          referencedTable: $$ChapterTableTableReferences
                              ._favoritePageTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChapterTableTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritePageTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chapterId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ChapterTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChapterTableTable,
      ChapterRow,
      $$ChapterTableTableFilterComposer,
      $$ChapterTableTableOrderingComposer,
      $$ChapterTableTableAnnotationComposer,
      $$ChapterTableTableCreateCompanionBuilder,
      $$ChapterTableTableUpdateCompanionBuilder,
      (ChapterRow, $$ChapterTableTableReferences),
      ChapterRow,
      PrefetchHooks Function({
        bool mangaId,
        bool pageTableRefs,
        bool favoritePageTableRefs,
      })
    >;
typedef $$PageTableTableCreateCompanionBuilder =
    PageTableCompanion Function({
      Value<int> id,
      required int chapterId,
      required int pageIndex,
      required String url,
      Value<String?> localPath,
    });
typedef $$PageTableTableUpdateCompanionBuilder =
    PageTableCompanion Function({
      Value<int> id,
      Value<int> chapterId,
      Value<int> pageIndex,
      Value<String> url,
      Value<String?> localPath,
    });

final class $$PageTableTableReferences
    extends BaseReferences<_$AppDatabase, $PageTableTable, PageRow> {
  $$PageTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChapterTableTable _chapterIdTable(_$AppDatabase db) =>
      db.chapterTable.createAlias(
        $_aliasNameGenerator(db.pageTable.chapterId, db.chapterTable.id),
      );

  $$ChapterTableTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<int>('chapter_id')!;

    final manager = $$ChapterTableTableTableManager(
      $_db,
      $_db.chapterTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PageTableTableFilterComposer
    extends Composer<_$AppDatabase, $PageTableTable> {
  $$PageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  $$ChapterTableTableFilterComposer get chapterId {
    final $$ChapterTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapterTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChapterTableTableFilterComposer(
            $db: $db,
            $table: $db.chapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PageTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PageTableTable> {
  $$PageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChapterTableTableOrderingComposer get chapterId {
    final $$ChapterTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapterTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChapterTableTableOrderingComposer(
            $db: $db,
            $table: $db.chapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PageTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PageTableTable> {
  $$PageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageIndex =>
      $composableBuilder(column: $table.pageIndex, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  $$ChapterTableTableAnnotationComposer get chapterId {
    final $$ChapterTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapterTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChapterTableTableAnnotationComposer(
            $db: $db,
            $table: $db.chapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PageTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PageTableTable,
          PageRow,
          $$PageTableTableFilterComposer,
          $$PageTableTableOrderingComposer,
          $$PageTableTableAnnotationComposer,
          $$PageTableTableCreateCompanionBuilder,
          $$PageTableTableUpdateCompanionBuilder,
          (PageRow, $$PageTableTableReferences),
          PageRow,
          PrefetchHooks Function({bool chapterId})
        > {
  $$PageTableTableTableManager(_$AppDatabase db, $PageTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PageTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PageTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PageTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> chapterId = const Value.absent(),
                Value<int> pageIndex = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
              }) => PageTableCompanion(
                id: id,
                chapterId: chapterId,
                pageIndex: pageIndex,
                url: url,
                localPath: localPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int chapterId,
                required int pageIndex,
                required String url,
                Value<String?> localPath = const Value.absent(),
              }) => PageTableCompanion.insert(
                id: id,
                chapterId: chapterId,
                pageIndex: pageIndex,
                url: url,
                localPath: localPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PageTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({chapterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (chapterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.chapterId,
                                referencedTable: $$PageTableTableReferences
                                    ._chapterIdTable(db),
                                referencedColumn: $$PageTableTableReferences
                                    ._chapterIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PageTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PageTableTable,
      PageRow,
      $$PageTableTableFilterComposer,
      $$PageTableTableOrderingComposer,
      $$PageTableTableAnnotationComposer,
      $$PageTableTableCreateCompanionBuilder,
      $$PageTableTableUpdateCompanionBuilder,
      (PageRow, $$PageTableTableReferences),
      PageRow,
      PrefetchHooks Function({bool chapterId})
    >;
typedef $$FavoritePageTableTableCreateCompanionBuilder =
    FavoritePageTableCompanion Function({
      Value<int> id,
      required String mangaId,
      required int chapterId,
      required int pageIndex,
      Value<DateTime> createdAt,
    });
typedef $$FavoritePageTableTableUpdateCompanionBuilder =
    FavoritePageTableCompanion Function({
      Value<int> id,
      Value<String> mangaId,
      Value<int> chapterId,
      Value<int> pageIndex,
      Value<DateTime> createdAt,
    });

final class $$FavoritePageTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FavoritePageTableTable,
          FavoritePageRow
        > {
  $$FavoritePageTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MangaTableTable _mangaIdTable(_$AppDatabase db) =>
      db.mangaTable.createAlias(
        $_aliasNameGenerator(
          db.favoritePageTable.mangaId,
          db.mangaTable.identifier,
        ),
      );

  $$MangaTableTableProcessedTableManager get mangaId {
    final $_column = $_itemColumn<String>('manga_id')!;

    final manager = $$MangaTableTableTableManager(
      $_db,
      $_db.mangaTable,
    ).filter((f) => f.identifier.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mangaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ChapterTableTable _chapterIdTable(_$AppDatabase db) =>
      db.chapterTable.createAlias(
        $_aliasNameGenerator(
          db.favoritePageTable.chapterId,
          db.chapterTable.id,
        ),
      );

  $$ChapterTableTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<int>('chapter_id')!;

    final manager = $$ChapterTableTableTableManager(
      $_db,
      $_db.chapterTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FavoritePageTableTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritePageTableTable> {
  $$FavoritePageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MangaTableTableFilterComposer get mangaId {
    final $$MangaTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mangaId,
      referencedTable: $db.mangaTable,
      getReferencedColumn: (t) => t.identifier,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MangaTableTableFilterComposer(
            $db: $db,
            $table: $db.mangaTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChapterTableTableFilterComposer get chapterId {
    final $$ChapterTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapterTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChapterTableTableFilterComposer(
            $db: $db,
            $table: $db.chapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritePageTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritePageTableTable> {
  $$FavoritePageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MangaTableTableOrderingComposer get mangaId {
    final $$MangaTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mangaId,
      referencedTable: $db.mangaTable,
      getReferencedColumn: (t) => t.identifier,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MangaTableTableOrderingComposer(
            $db: $db,
            $table: $db.mangaTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChapterTableTableOrderingComposer get chapterId {
    final $$ChapterTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapterTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChapterTableTableOrderingComposer(
            $db: $db,
            $table: $db.chapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritePageTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritePageTableTable> {
  $$FavoritePageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageIndex =>
      $composableBuilder(column: $table.pageIndex, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MangaTableTableAnnotationComposer get mangaId {
    final $$MangaTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mangaId,
      referencedTable: $db.mangaTable,
      getReferencedColumn: (t) => t.identifier,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MangaTableTableAnnotationComposer(
            $db: $db,
            $table: $db.mangaTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChapterTableTableAnnotationComposer get chapterId {
    final $$ChapterTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapterTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChapterTableTableAnnotationComposer(
            $db: $db,
            $table: $db.chapterTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritePageTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritePageTableTable,
          FavoritePageRow,
          $$FavoritePageTableTableFilterComposer,
          $$FavoritePageTableTableOrderingComposer,
          $$FavoritePageTableTableAnnotationComposer,
          $$FavoritePageTableTableCreateCompanionBuilder,
          $$FavoritePageTableTableUpdateCompanionBuilder,
          (FavoritePageRow, $$FavoritePageTableTableReferences),
          FavoritePageRow,
          PrefetchHooks Function({bool mangaId, bool chapterId})
        > {
  $$FavoritePageTableTableTableManager(
    _$AppDatabase db,
    $FavoritePageTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritePageTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritePageTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritePageTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> mangaId = const Value.absent(),
                Value<int> chapterId = const Value.absent(),
                Value<int> pageIndex = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FavoritePageTableCompanion(
                id: id,
                mangaId: mangaId,
                chapterId: chapterId,
                pageIndex: pageIndex,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String mangaId,
                required int chapterId,
                required int pageIndex,
                Value<DateTime> createdAt = const Value.absent(),
              }) => FavoritePageTableCompanion.insert(
                id: id,
                mangaId: mangaId,
                chapterId: chapterId,
                pageIndex: pageIndex,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FavoritePageTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mangaId = false, chapterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mangaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mangaId,
                                referencedTable:
                                    $$FavoritePageTableTableReferences
                                        ._mangaIdTable(db),
                                referencedColumn:
                                    $$FavoritePageTableTableReferences
                                        ._mangaIdTable(db)
                                        .identifier,
                              )
                              as T;
                    }
                    if (chapterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.chapterId,
                                referencedTable:
                                    $$FavoritePageTableTableReferences
                                        ._chapterIdTable(db),
                                referencedColumn:
                                    $$FavoritePageTableTableReferences
                                        ._chapterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FavoritePageTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritePageTableTable,
      FavoritePageRow,
      $$FavoritePageTableTableFilterComposer,
      $$FavoritePageTableTableOrderingComposer,
      $$FavoritePageTableTableAnnotationComposer,
      $$FavoritePageTableTableCreateCompanionBuilder,
      $$FavoritePageTableTableUpdateCompanionBuilder,
      (FavoritePageRow, $$FavoritePageTableTableReferences),
      FavoritePageRow,
      PrefetchHooks Function({bool mangaId, bool chapterId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MangaTableTableTableManager get mangaTable =>
      $$MangaTableTableTableManager(_db, _db.mangaTable);
  $$ChapterTableTableTableManager get chapterTable =>
      $$ChapterTableTableTableManager(_db, _db.chapterTable);
  $$PageTableTableTableManager get pageTable =>
      $$PageTableTableTableManager(_db, _db.pageTable);
  $$FavoritePageTableTableTableManager get favoritePageTable =>
      $$FavoritePageTableTableTableManager(_db, _db.favoritePageTable);
}
