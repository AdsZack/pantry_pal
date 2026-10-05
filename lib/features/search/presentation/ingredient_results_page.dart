import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pal/core/widgets/message_view.dart';
import 'package:pantry_pal/features/search/presentation/ingredient_search_notifier.dart';
import 'package:pantry_pal/features/search/presentation/selected_ingredients_notifier.dart';
import 'package:pantry_pal/features/search/presentation/widgets/recipe_card.dart';
import 'package:pantry_pal/features/search/presentation/widgets/recipe_card_skeleton.dart';

class IngredientResultsPage extends ConsumerWidget {
  const IngredientResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(ingredientSearchProvider);
    final selected = ref.watch(selectedIngredientsProvider);
    final notifier = ref.read(ingredientSearchProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Recipe for you')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.fromLTRB(16, 8, 16, 8),
            child: Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [for (final name in selected) Chip(label: Text(name))],
              ),
            ),
          ),
          Expanded(
            child: results.when(
              data: (recipes) {
                if (recipes.isEmpty) {
                  return MessageView(
                    icon: Icons.search_off, 
                    text: 'No recipe uses all of these ingredients',
                    action: OutlinedButton(
                      onPressed: () => context.pop(), 
                      child: const Text('Edit ingredients')
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: recipes.length,
                  separatorBuilder: (context, i) => const SizedBox(height: 8),
                  itemBuilder: (context, i) => RecipeCard(recipe: recipes[i]), 
                );
              }, 
              error: (error, stack) => MessageView(
                icon: Icons.wifi_off, 
                text: 'Something went wrong',
                action: FilledButton(
                  onPressed: notifier.search, 
                  child: const Text('Retry')
                ),
              ), 
              loading: () => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, i) => const RecipeCardSkeleton(), 
                separatorBuilder: (context, i) => const SizedBox(height: 8), 
                itemCount: 6
              )
            )
          )
        ],
      ),
    );
  }
}