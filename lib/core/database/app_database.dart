import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_database.g.dart';

@DataClassName('FavoriteRow')
class FavoriteRecipes extends Table {
  TextColumn get id => text()();
  TextColumn get payload => text()();
  DateTimeColumn get savedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SearchCacheRow')
class SearchCaches extends Table {
  TextColumn get term => text()();
  TextColumn get payload => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {term};
}

@DriftDatabase(tables: [FavoriteRecipes, SearchCaches])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'pantry_pal'));

  @override
  int get schemaVersion => 1;

  // Favorite
  Stream<List<FavoriteRow>> watchFavorites() {
    return (select(favoriteRecipes)
      ..orderBy([(t) => OrderingTerm.desc(t.savedAt)]))
      .watch();
  }

  Stream<bool> watchIsFavorite(String id) {
    return (select(favoriteRecipes)..where((t) => t.id.equals(id)))
        .watchSingleOrNull()
        .map((row) => row != null);
  }

  Future<String?> getFavoritePayload(String id) async {
    final row = await (select(favoriteRecipes)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
      return row?.payload;
  }

  Future<void> putFavorite(String id, String payload) {
    return into(favoriteRecipes).insertOnConflictUpdate(
      FavoriteRecipesCompanion.insert(
        id: id,
        payload: payload,
        savedAt: DateTime.now(),
      ),
    );
  }

  Future<void> deleteFavorite(String id) {
    return (delete(favoriteRecipes)..where((t) => t.id.equals(id))).go();
  }

  // Search Cache
  Future<String?> getSearchCache(String term) async {
    final row = await (select(searchCaches)..where((t) => t.term.equals(term)))
        .getSingleOrNull();
      return row?.payload;
  }

  Future<void> putSearchCache(String term, String payload) {
    return into(searchCaches).insertOnConflictUpdate(
      SearchCachesCompanion.insert(
        term: term,
        payload: payload,
        cachedAt: DateTime.now(),
      ),
    );
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});