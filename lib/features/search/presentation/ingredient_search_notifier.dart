import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/features/search/data/recipe_repository_impl.dart';
import 'package:pantry_pal/features/search/domain/recipe.dart';
import 'package:pantry_pal/features/search/presentation/selected_ingredients_notifier.dart';

class IngredientSearchNotifier extends AsyncNotifier<List<Recipe>> {
  @override
  Future<List<Recipe>> build() async => [];

  Future<void> search() async {
    final ingredients = ref.read(selectedIngredientsProvider);

    // If Empty Query
    if(ingredients.isEmpty) {
      state = AsyncData(<Recipe>[]);
      return;
    }

    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(recipeRepositoryProvider).searchByIngredients(ingredients),
    );
  }
}

final ingredientSearchProvider = 
  AsyncNotifierProvider<IngredientSearchNotifier, List<Recipe>>(IngredientSearchNotifier.new
);