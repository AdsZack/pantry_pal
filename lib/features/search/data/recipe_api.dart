import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/core/network/dio_client.dart';
import 'package:pantry_pal/features/search/data/recipe_dto.dart';

class RecipeApi {
  RecipeApi(this._dio);

  final Dio _dio;

  Future<List<RecipeDTO>> searchByName(String query) async {
    final res = await _dio.get('/search.php', queryParameters: {'s': query});

    // TheMealDB returns Null
    final meals = res.data['meal'] as List?;
    if (meals == null) return [];

    return meals
      .map((e) => RecipeDTO.fromJson(e as Map<String, dynamic>))
      .toList();
  }
}

final recipeProvider = Provider<RecipeApi>((ref) {
  return RecipeApi(ref.watch(dioProvider));
});