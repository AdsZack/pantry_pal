import 'package:pantry_pal/features/search/domain/recipe.dart';

String normalizeIngredient(String raw) =>
  raw.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');

// Normalize every name
List<String> normalizeIngredients(Iterable<String> raw) {
  final seen = <String>{};
  for (final item in raw) {
    final name = normalizeIngredient(item);
    if (name.isNotEmpty) seen.add(name);
  }
  return seen.toList();
}

// Keep only recipe with Id
List<Recipe> intersectById(List<List<Recipe>> lists) {
  if (lists.isEmpty) return [];
  final commonIds = lists
    .map((list) => list.map((r) => r.id).toSet())
    .reduce((a, b) => a.intersection(b));
  return lists.first.where((r) => commonIds.contains(r.id)).toList();
}