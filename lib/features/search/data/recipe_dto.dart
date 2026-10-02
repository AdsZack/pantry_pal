import 'package:pantry_pal/features/search/domain/recipe.dart';

class RecipeDTO {
  RecipeDTO({
    required this.id,
    required this.name,
    this.category,
    this.area,
    this.instructions,
    this.thumbnail,
    this.youtubeUrl,
    this.ingredients = const [],
  });

  final String id;
  final String name;
  final String? category;
  final String? area;
  final String? instructions;
  final String? thumbnail;
  final String? youtubeUrl;
  final List<Ingredient> ingredients;

  factory RecipeDTO.fromJson(Map<String, dynamic> json) {
    final ingredients = <Ingredient>[];
    for (var i = 1; i <= 20; i++) {
      final name = (json['strIngredient$i'] as String?)?.trim();
      final measure = (json['strMeasure$i'] as String?)?.trim() ?? '';
      if (name != null && name.isNotEmpty) {
        ingredients.add(Ingredient(name: name, measure: measure));
      }
    }

    return RecipeDTO(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      category: json['strCategory'] as String?,
      area: json['strArea'] as String?,
      instructions: json['strInstructions'] as String?,
      thumbnail: json['strMealThumb'] as String?,
      youtubeUrl: json['strYoutube'] as String?,
      ingredients: ingredients,
    );
  }
  Recipe toDomain() => Recipe(
      id: id,
      name: name,
      category: category,
      area: area,
      instructions: instructions,
      thumbnail: thumbnail,
      youtubeUrl: (youtubeUrl?.isEmpty ?? true) ? null : youtubeUrl,
      ingredients: ingredients,
    );
}