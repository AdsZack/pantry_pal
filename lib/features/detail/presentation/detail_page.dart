import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/core/widgets/message_view.dart';
import 'package:pantry_pal/features/detail/presentation/detail_provider.dart';
import 'package:pantry_pal/features/detail/presentation/widgets/ingredient_row.dart';
import 'package:pantry_pal/features/detail/presentation/widgets/instruction_steps.dart';
import 'package:pantry_pal/features/favorites/data/favorites_repository.dart';
import 'package:pantry_pal/features/search/domain/recipe.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipe = ref.watch(recipeDetailProvider(id));

    return recipe.when(
      data: (recipe) => _DetailContent(recipe: recipe), 
      error: (error, stack) => Scaffold(
        appBar: AppBar(),
        body: MessageView(
          icon: Icons.wifi_off, 
          text: "Couldn't load this recipe",
          action: FilledButton(
            onPressed: () => ref.invalidate(recipeDetailProvider(id)), 
            child: const Text('Retry'),
          ),
        ),
      ),
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      )
    );
  }
}

class _DetailContent extends ConsumerWidget {
  const _DetailContent({required this.recipe});

  final Recipe recipe;

  Future<void> _openVideo(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    final opened =
      uri != null && await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Couldn't open the video")),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final videoUrl = recipe.youtubeUrl;

    final isFav = ref.watch(isFavoriteProvider(recipe.id)).value ?? false;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            actions: [
              IconButton(
                onPressed: () => ref.read(favoritesRepositoryProvider).toggle(recipe), 
                tooltip: isFav ? 'Remove from favorite' : 'Save',
                icon: Icon( isFav ? Icons.favorite : Icons.favorite_border)
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: recipe.thumbnail == null
                ? ColoredBox(color: scheme.surfaceContainerHighest)
                : CachedNetworkImage(
                  imageUrl: recipe.thumbnail!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                    ColoredBox(color: scheme.surfaceContainerHighest),
                  ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name, style: textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (recipe.category != null)
                        Chip(label: Text(recipe.category!)),
                      if (recipe.area != null) 
                        Chip(label: Text(recipe.area!)),
                    ],
                  ),
                  if (videoUrl != null) ...[
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () => _openVideo(context, videoUrl), 
                      icon: const Icon(Icons.play_circle_outlined),
                      label: const Text('Watch video'),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text('Ingredients', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  for (final item in recipe.ingredients)
                    IngredientRow(ingredient: item),
                  const SizedBox(height: 24),
                  Text('Instruction', style: textTheme.titleMedium),
                  InstructionSteps(text: recipe.instructions ?? ''),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}