import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/recipe.dart';
import 'search_notifier.dart';

typedef SearchFilter = ({String? category, String? area});

class SearchFilterNotifier extends Notifier<SearchFilter> {
  @override
  SearchFilter build() => (category: null, area: null);

  // Tap the selected chip to turn off
  void toggleCategory(String value) {
    state = (
      category: state.category == value ? null : value,
      area: state.area,
    );
  }

  void toggleArea(String value) {
    state = (
      category: state.category,
      area: state.area == value ? null : value,
    );
  }

  void clear() => state = (category:null, area: null);
}

final searchFilterProvider = 
  NotifierProvider<SearchFilterNotifier, SearchFilter>(
    SearchFilterNotifier.new,
);

/// Result with the chosen category/area applied
/// Filter happen without extra API
final filteredResultsProvider = Provider<AsyncValue<List<Recipe>>> ((ref) {
  final results = ref.watch(searchProvider);
  final filter = ref.watch(searchFilterProvider);

  return results.whenData(
    (list) => list
      ..where((r) =>
        (filter.category == null || r.category == filter.category) &&
        (filter.area == null || r.area == filter.area))
      .toList(),
  );
});

List<String> distinctSorted(Iterable<String?> values) {
  final unique = values.whereType<String>().where((v) => v.isNotEmpty).toSet();
  return unique.toList()..sort();
}