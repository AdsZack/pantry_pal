import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/features/search/data/recipe_repository_impl.dart';
import 'package:pantry_pal/features/search/domain/recipe.dart';

final recipeDetailProvider = 
  FutureProvider.family<Recipe, String>((ref, id) {
    return ref.watch(recipeRepositoryProvider).getById(id);
});