import 'package:pantry_pal/features/search/domain/recipe.dart';

Map<String, dynamic> recipeToJson(Recipe r) => {
  'id': r.id,
  'name': r.name,
  'category': r.category,
  'area': r.area,
  'instructions': r.instructions,
  'thumbnail': r.thumbnail,
  'youtubeUrl': r.youtubeUrl,
  'ingredients': [
    for (final i in r.ingredients) {'name': i.name, 'measure': i.measure},
  ],
};

Recipe recipeFromJson(Map<String, dynamic> j) => Recipe(
  id: j['i'] as String,
  name: j['name'] as String,
  category: j['category'] as String?,
  area: j['area'] as String?,
  instructions: j['instructions'] as String?,
  thumbnail: j['thumbnail'] as String?,
  youtubeUrl: j['youtubeUrl'] as String?,
  ingredients: [
    for (final i in (j['ingredients'] as List? ?? []))
      Ingredient(
        name: i['name'] as String, 
        measure: (i['measure'] as String?) ?? '',
      ),
  ],
);