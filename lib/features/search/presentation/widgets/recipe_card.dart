import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pal/features/search/domain/recipe.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitle = 
      [recipe.category, recipe.area].whereType<String>().join(' - ');

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => context.push('/recipe/${recipe.id}'),
        child: Row(
          children: [
            SizedBox(
              width: 88,
              height: 88,
              child: recipe.thumbnail == null
                ? const Icon(Icons.restaurant)
                : CachedNetworkImage(
                    imageUrl: recipe.thumbnail!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                      const Icon(Icons.broken_image_outlined),
                  ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      recipe.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium,
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(subtitle, style: textTheme.bodySmall),
                    ],
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}