import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/features/search/data/recipe_api.dart';
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
}

final recipeRepositoryProvider = Provider<RecipeRepository> ((ref) {
  return RecipeRepositoryImpl(ref.watch(recipeProvider));
});