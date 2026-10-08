import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/core/database/app_database.dart';
import 'package:pantry_pal/features/search/data/recipe_json.dart';
import 'package:pantry_pal/features/search/domain/recipe.dart';

class FavoritesRepository {
  FavoritesRepository(this._db);

  final AppDatabase _db;

  Stream<List<Recipe>> watchAll() {
    return _db.watchFavorites().map(
      (rows) => rows
        .map((r) => recipeFromJson(
          jsonDecode(r.payload) as Map<String, dynamic>))
        .toList(),
    );
  }

  Stream<bool> watchIsFavorite(String id) => _db.watchIsFavorite(id);

  Future<void> add(Recipe recipe) {
    return _db.putFavorite(recipe.id, jsonEncode(recipeToJson(recipe)));
  }

  Future<void> remove(String id) => _db.deleteFavorite(id);

  // Hear Button
  Future<void> toggle(Recipe recipe) async {
    final existing = await _db.getFavoritePayload(recipe.id);
    if (existing == null) {
      await add(recipe);
    } else {
      await remove(recipe.id);
    }
  }
}

final favoritesRepositoryProvider = Provider<FavoritesRepository> ((ref) {
  return FavoritesRepository(ref.watch(appDatabaseProvider));
});

// All saved recipe, newest, update itself
final favoritesProvider = StreamProvider<List<Recipe>> ((ref) {
  return ref.watch(favoritesRepositoryProvider).watchAll();
});

// Is this recipe saved?
final isFavoriteProvider = StreamProvider.family<bool, String> ((ref, id) {
  return ref.watch(favoritesRepositoryProvider).watchIsFavorite(id);
});