import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/features/search/data/recipe_repository_impl.dart';
import 'package:pantry_pal/features/search/domain/recipe.dart';

class SearchNotifier extends AsyncNotifier<List<Recipe>> {
  String _lasQuery = '';

  @override
  Future<List<Recipe>> build() async => [];

  Future<void> search(String query) async {
    final q = query.trim();
    _lasQuery = q;

    // If Empty Query
    if(q.isEmpty) {
      state = AsyncData(<Recipe>[]);
      return;
    }

    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(recipeRepositoryProvider).search(q),
    );

    // User may type something
    if(q != _lasQuery) return;
    state = result;
  }

  Future<void> retry() => search(_lasQuery);
}

final searchProvider = 
  AsyncNotifierProvider<SearchNotifier, List<Recipe>>(SearchNotifier.new);