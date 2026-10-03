import 'package:pantry_pal/features/search/domain/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> search(String query);
}