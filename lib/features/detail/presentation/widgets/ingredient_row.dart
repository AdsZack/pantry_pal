import 'package:flutter/material.dart';
import 'package:pantry_pal/features/search/domain/recipe.dart';

class IngredientRow extends StatelessWidget {
  const IngredientRow({super.key, required this.ingredient});

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final measure = ingredient.measure.trim();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              measure.isEmpty ? '-' : measure,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(ingredient.name, style: textTheme.bodyLarge)),
        ],
      ),
    );
  }
}