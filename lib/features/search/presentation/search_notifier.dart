import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/recipe_repository_impl.dart';
import '../domain/recipe.dart';

/// Step 4: holds search state. AsyncValue = loading | data | error.
class SearchNotifier extends AsyncNotifier<List<Recipe>> {
  String _lastQuery = '';

  @override
  Future<List<Recipe>> build() async => [];

  Future<void> search(String query) async {
    final q = query.trim();
    _lastQuery = q;

    // Empty query: reset, don't call the API
    if (q.isEmpty) {
      state = AsyncData(<Recipe>[]);
      return;
    }

    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(recipeRepositoryProvider).search(q),
    );

    // The user may have typed something newer while we waited: ignore stale result
    if (q != _lastQuery) return;
    state = result;
  }

  Future<void> retry() => search(_lastQuery);
}

final searchProvider =
    AsyncNotifierProvider<SearchNotifier, List<Recipe>>(SearchNotifier.new);
