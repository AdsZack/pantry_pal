import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/features/search/data/recipe_api.dart';
import 'package:pantry_pal/features/search/domain/ingredient_utils.dart';
import 'package:pantry_pal/features/search/domain/recipe.dart';
import 'package:pantry_pal/features/search/domain/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository{
  RecipeRepositoryImpl(this._api);

  final RecipeApi _api;

  @override
  Future<List<Recipe>> search(String query) async {
    final dtos = await _api.searchByName(query);
    return dtos.map((d) => d.toDomain()).toList();
  }

  @override
  Future<Recipe> getById(String id) async {
    final dto = await _api.getById(id);
    if(dto == null) throw Exception('Recipe $id not found');
    return dto.toDomain();
  }

  @override
  Future<List<Recipe>> searchByIngredients(List<String> ingredients) async {
    final names = normalizeIngredients(ingredients);
    if (names.isEmpty) return [];

    final responses = await Future.wait(names.map(_api.filterByIngredient));

    final lists = responses
      .map((dtos) => dtos.map((d) => d.toDomain()).toList())
      .toList();

    return intersectById(lists);
  }
}

final recipeRepositoryProvider = Provider<RecipeRepository> ((ref) {
  return RecipeRepositoryImpl(ref.watch(recipeProvider));
});