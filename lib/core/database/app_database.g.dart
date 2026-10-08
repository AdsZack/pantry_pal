// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FavoriteRecipesTable extends FavoriteRecipes
    with TableInfo<$FavoriteRecipesTable, FavoriteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, payload, savedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $FavoriteRecipesTable createAlias(String alias) {
    return $FavoriteRecipesTable(attachedDatabase, alias);
  }
}

class FavoriteRow extends DataClass implements Insertable<FavoriteRow> {
  final String id;
  final String payload;
  final DateTime savedAt;
  const FavoriteRow({
    required this.id,
    required this.payload,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payload'] = Variable<String>(payload);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  FavoriteRecipesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteRecipesCompanion(
      id: Value(id),
      payload: Value(payload),
      savedAt: Value(savedAt),
    );
  }

  factory FavoriteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteRow(
      id: serializer.fromJson<String>(json['id']),
      payload: serializer.fromJson<String>(json['payload']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'payload': serializer.toJson<String>(payload),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  FavoriteRow copyWith({String? id, String? payload, DateTime? savedAt}) =>
      FavoriteRow(
        id: id ?? this.id,
        payload: payload ?? this.payload,
        savedAt: savedAt ?? this.savedAt,
      );
  FavoriteRow copyWithCompanion(FavoriteRecipesCompanion data) {
    return FavoriteRow(
      id: data.id.present ? data.id.value : this.id,
      payload: data.payload.present ? data.payload.value : this.payload,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRow(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payload, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteRow &&
          other.id == this.id &&
          other.payload == this.payload &&
          other.savedAt == this.savedAt);
}

class FavoriteRecipesCompanion extends UpdateCompanion<FavoriteRow> {
  final Value<String> id;
  final Value<String> payload;
  final Value<DateTime> savedAt;
  final Value<int> rowid;
  const FavoriteRecipesCompanion({
    this.id = const Value.absent(),
    this.payload = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteRecipesCompanion.insert({
    required String id,
    required String payload,
    required DateTime savedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       payload = Value(payload),
       savedAt = Value(savedAt);
  static Insertable<FavoriteRow> custom({
    Expression<String>? id,
    Expression<String>? payload,
    Expression<DateTime>? savedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payload != null) 'payload': payload,
      if (savedAt != null) 'saved_at': savedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteRecipesCompanion copyWith({
    Value<String>? id,
    Value<String>? payload,
    Value<DateTime>? savedAt,
    Value<int>? rowid,
  }) {
    return FavoriteRecipesCompanion(
      id: id ?? this.id,
      payload: payload ?? this.payload,
      savedAt: savedAt ?? this.savedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRecipesCompanion(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('savedAt: $savedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SearchCachesTable extends SearchCaches
    with TableInfo<$SearchCachesTable, SearchCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchCachesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
    'term',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [term, payload, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_caches';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('term')) {
      context.handle(
        _termMeta,
        term.isAcceptableOrUnknown(data['term']!, _termMeta),
      );
    } else if (isInserting) {
      context.missing(_termMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {term};
  @override
  SearchCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchCacheRow(
      term: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}term'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $SearchCachesTable createAlias(String alias) {
    return $SearchCachesTable(attachedDatabase, alias);
  }
}

class SearchCacheRow extends DataClass implements Insertable<SearchCacheRow> {
  final String term;
  final String payload;
  final DateTime cachedAt;
  const SearchCacheRow({
    required this.term,
    required this.payload,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['term'] = Variable<String>(term);
    map['payload'] = Variable<String>(payload);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  SearchCachesCompanion toCompanion(bool nullToAbsent) {
    return SearchCachesCompanion(
      term: Value(term),
      payload: Value(payload),
      cachedAt: Value(cachedAt),
    );
  }

  factory SearchCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchCacheRow(
      term: serializer.fromJson<String>(json['term']),
      payload: serializer.fromJson<String>(json['payload']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'term': serializer.toJson<String>(term),
      'payload': serializer.toJson<String>(payload),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  SearchCacheRow copyWith({
    String? term,
    String? payload,
    DateTime? cachedAt,
  }) => SearchCacheRow(
    term: term ?? this.term,
    payload: payload ?? this.payload,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  SearchCacheRow copyWithCompanion(SearchCachesCompanion data) {
    return SearchCacheRow(
      term: data.term.present ? data.term.value : this.term,
      payload: data.payload.present ? data.payload.value : this.payload,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchCacheRow(')
          ..write('term: $term, ')
          ..write('payload: $payload, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(term, payload, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchCacheRow &&
          other.term == this.term &&
          other.payload == this.payload &&
          other.cachedAt == this.cachedAt);
}

class SearchCachesCompanion extends UpdateCompanion<SearchCacheRow> {
  final Value<String> term;
  final Value<String> payload;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const SearchCachesCompanion({
    this.term = const Value.absent(),
    this.payload = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchCachesCompanion.insert({
    required String term,
    required String payload,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : term = Value(term),
       payload = Value(payload),
       cachedAt = Value(cachedAt);
  static Insertable<SearchCacheRow> custom({
    Expression<String>? term,
    Expression<String>? payload,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (term != null) 'term': term,
      if (payload != null) 'payload': payload,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchCachesCompanion copyWith({
    Value<String>? term,
    Value<String>? payload,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return SearchCachesCompanion(
      term: term ?? this.term,
      payload: payload ?? this.payload,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchCachesCompanion(')
          ..write('term: $term, ')
          ..write('payload: $payload, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteRecipesTable favoriteRecipes = $FavoriteRecipesTable(
    this,
  );
  late final $SearchCachesTable searchCaches = $SearchCachesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favoriteRecipes,
    searchCaches,
  ];
}

typedef $$FavoriteRecipesTableCreateCompanionBuilder =
    FavoriteRecipesCompanion Function({
      required String id,
      required String payload,
      required DateTime savedAt,
      Value<int> rowid,
    });
typedef $$FavoriteRecipesTableUpdateCompanionBuilder =
    FavoriteRecipesCompanion Function({
      Value<String> id,
      Value<String> payload,
      Value<DateTime> savedAt,
      Value<int> rowid,
    });

class $$FavoriteRecipesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteRecipesTable> {
  $$FavoriteRecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteRecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteRecipesTable> {
  $$FavoriteRecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteRecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteRecipesTable> {
  $$FavoriteRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$FavoriteRecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteRecipesTable,
          FavoriteRow,
          $$FavoriteRecipesTableFilterComposer,
          $$FavoriteRecipesTableOrderingComposer,
          $$FavoriteRecipesTableAnnotationComposer,
          $$FavoriteRecipesTableCreateCompanionBuilder,
          $$FavoriteRecipesTableUpdateCompanionBuilder,
          (
            FavoriteRow,
            BaseReferences<_$AppDatabase, $FavoriteRecipesTable, FavoriteRow>,
          ),
          FavoriteRow,
          PrefetchHooks Function()
        > {
  $$FavoriteRecipesTableTableManager(
    _$AppDatabase db,
    $FavoriteRecipesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteRecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteRecipesCompanion(
                id: id,
                payload: payload,
                savedAt: savedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String payload,
                required DateTime savedAt,
                Value<int> rowid = const Value.absent(),
              }) => FavoriteRecipesCompanion.insert(
                id: id,
                payload: payload,
                savedAt: savedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoriteRecipesTable, FavoriteRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FavoriteRecipesTable,
                    FavoriteRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteRecipesTable,
      FavoriteRow,
      $$FavoriteRecipesTableFilterComposer,
      $$FavoriteRecipesTableOrderingComposer,
      $$FavoriteRecipesTableAnnotationComposer,
      $$FavoriteRecipesTableCreateCompanionBuilder,
      $$FavoriteRecipesTableUpdateCompanionBuilder,
      (
        FavoriteRow,
        BaseReferences<_$AppDatabase, $FavoriteRecipesTable, FavoriteRow>,
      ),
      FavoriteRow,
      PrefetchHooks Function()
    >;
typedef $$SearchCachesTableCreateCompanionBuilder =
    SearchCachesCompanion Function({
      required String term,
      required String payload,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$SearchCachesTableUpdateCompanionBuilder =
    SearchCachesCompanion Function({
      Value<String> term,
      Value<String> payload,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$SearchCachesTableFilterComposer
    extends Composer<_$AppDatabase, $SearchCachesTable> {
  $$SearchCachesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SearchCachesTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchCachesTable> {
  $$SearchCachesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get term => $composableBuilder(
    column: $table.term,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchCachesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchCachesTable> {
  $$SearchCachesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get term =>
      $composableBuilder(column: $table.term, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$SearchCachesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchCachesTable,
          SearchCacheRow,
          $$SearchCachesTableFilterComposer,
          $$SearchCachesTableOrderingComposer,
          $$SearchCachesTableAnnotationComposer,
          $$SearchCachesTableCreateCompanionBuilder,
          $$SearchCachesTableUpdateCompanionBuilder,
          (
            SearchCacheRow,
            BaseReferences<_$AppDatabase, $SearchCachesTable, SearchCacheRow>,
          ),
          SearchCacheRow,
          PrefetchHooks Function()
        > {
  $$SearchCachesTableTableManager(_$AppDatabase db, $SearchCachesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchCachesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchCachesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchCachesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> term = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchCachesCompanion(
                term: term,
                payload: payload,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String term,
                required String payload,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => SearchCachesCompanion.insert(
                term: term,
                payload: payload,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SearchCachesTable, SearchCacheRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SearchCachesTable,
                    SearchCacheRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SearchCachesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchCachesTable,
      SearchCacheRow,
      $$SearchCachesTableFilterComposer,
      $$SearchCachesTableOrderingComposer,
      $$SearchCachesTableAnnotationComposer,
      $$SearchCachesTableCreateCompanionBuilder,
      $$SearchCachesTableUpdateCompanionBuilder,
      (
        SearchCacheRow,
        BaseReferences<_$AppDatabase, $SearchCachesTable, SearchCacheRow>,
      ),
      SearchCacheRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteRecipesTableTableManager get favoriteRecipes =>
      $$FavoriteRecipesTableTableManager(_db, _db.favoriteRecipes);
  $$SearchCachesTableTableManager get searchCaches =>
      $$SearchCachesTableTableManager(_db, _db.searchCaches);
}
