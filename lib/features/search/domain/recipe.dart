import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';

@freezed
abstract class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String name,
    required String measure,
  }) = _Ingredient;
}

@freezed
abstract class Recipe with _$Recipe {
  const factory Recipe ({
    required String id,
    required String name,
    String? category,
    String? area,
    String? instructions,
    String? thumbnail,
    String? youtubeUrl,
    @Default([]) List<Ingredient> ingredients,
  }) = _Recipe;
}