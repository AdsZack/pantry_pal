import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/core/network/dio_client.dart';
import 'package:pantry_pal/features/search/data/recipe_dto.dart';

class RecipeApi {
  RecipeApi(this._dio);

  final Dio _dio;

  // Search recipe by name
  Future<List<RecipeDTO>> searchByName(String query) async {
    final res = await _dio.get('/search.php', queryParameters: {'s': query});
    return _parseMeals(res.data);
  }

  // Search recipe by ID
  Future<RecipeDTO?> getById(String id) async {
    final res = await _dio.get('/lookup.php', queryParameters: {'i': id});
    final meals = _parseMeals(res.data);
    return meals.isEmpty ? null : meals.first;
  }

  // Filter
  Future<List<RecipeDTO>> filterByIngredient(String ingredient) async {
    final res = await _dio.get('/filter.php', queryParameters: {'i': ingredient});
    return _parseMeals(res.data);
  }

  List<RecipeDTO> _parseMeals(dynamic data) {
    if (data is! Map) return [];
    final meals = data['meals'];
    if (meals is! List) return [];
    return meals
      .map((e) => RecipeDTO.fromJson(e as Map<String, dynamic>))
      .toList();
  }
}

final recipeProvider = Provider<RecipeApi>((ref) {
  return RecipeApi(ref.watch(dioProvider));
});