import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/core/widgets/message_view.dart';
import 'package:pantry_pal/features/favorites/data/favorites_repository.dart';
import 'package:pantry_pal/features/search/presentation/widgets/recipe_card.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.when(
        data: (recipes) {
          if (recipes.isEmpty) {
            return const MessageView(
              icon: Icons.favorite_border, 
              text: "No favorite yet. Tap the heart on recipe to save it",
            );
          }
          return ListView.separated(
            itemBuilder: (context, i) {
              final recipe = recipes[i];
              return Dismissible(
                key: ValueKey(recipe.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete_outline),
                ),
                onDismissed: (_) {
                  final repo = ref.read(favoritesRepositoryProvider);
                  repo.remove(recipe.id);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: const Text('Remove from favorites'),
                        action: SnackBarAction(
                          label: 'Undo', 
                          onPressed: () => repo.add(recipe),
                        ),
                      )
                    );
                },
                child: RecipeCard(recipe: recipe),
              );
            }, 
            separatorBuilder: (context, i) => const SizedBox(height: 8), 
            itemCount: recipes.length
          );
        }, 
        error: (error, stack) => const MessageView(
          icon: Icons.error_outline, 
          text: "Couldn't load your favorite"
        ), 
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}