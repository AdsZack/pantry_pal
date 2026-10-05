import 'package:pantry_pal/features/search/domain/recipe.dart';

abstract class RecipeRepository {
  // Search recipe by name
  Future<List<Recipe>> search(String query);
  
  // Search recipe by Id
  Future<Recipe> getById(String id);

  // Search recipe by Id in all contain ingredient
  Future<List<Recipe>> searchByIngredients(List<String> ingredients);
}