import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/core/utils/debauncher.dart';
import 'package:pantry_pal/core/widgets/message_view.dart';
import 'package:pantry_pal/features/search/domain/recipe.dart';
import 'package:pantry_pal/features/search/presentation/recent_searches_notifier.dart';
import 'package:pantry_pal/features/search/presentation/search_filter.dart';
import 'package:pantry_pal/features/search/presentation/search_notifier.dart';
import 'package:pantry_pal/features/search/presentation/widgets/recipe_card.dart';
import 'package:pantry_pal/features/search/presentation/widgets/recipe_card_skeleton.dart';

class ResultsPage extends ConsumerStatefulWidget {
  const ResultsPage({super.key});

  @override
  ConsumerState<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends ConsumerState<ResultsPage> {
  final _controller = TextEditingController();
  final _debouncher = Debauncher();

  @override
  void dispose() {
    _controller.dispose();
    _debouncher.dispose();
    super.dispose();
  }

  /// [remember] = also save the query in "Recent seaches"
  void _runSearch(String query, {bool remember = false}) {
    ref.read(searchFilterProvider.notifier).clear();
    ref.read(searchProvider.notifier).search(query);
    if (remember) ref.read(recentSearchProvider.notifier).add(query);
  }

  void _pickRecent(String query) {
    _controller.text =query;
    _controller.selection = TextSelection.collapsed(offset: query.length);
    setState(() {
      _runSearch(query, remember: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchProvider);
    // final notifier = ref.read(searchProvider.notifier);
    final hasQUery = _controller.text.trim().isNotEmpty;
    final all = ref.watch(searchProvider).value ?? const <Recipe>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search recipes',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: (){
                    _controller.clear();
                    setState(() {});
                    _runSearch('');
                  },
                  icon: const Icon(Icons.close),
                )
              ),
              onChanged: (q) { 
                _debouncher.run(() => _runSearch(q));
                setState(() {});
              },
              onSubmitted: (q) => _runSearch(q, remember: true),
            ),
          ),
          if (hasQUery && all.isNotEmpty)
            _FilterBar(
              categories: distinctSorted(all.map((r) => r.category)),
              areas: distinctSorted(all.map((r) => r.area)),
            ),
          Expanded(
            child: !hasQUery
              ? _RecentSearches(onPick: _pickRecent)
              : results.when(
                loading: () => ListView.separated(
                  itemBuilder: (context, i) => const RecipeCardSkeleton(), 
                  separatorBuilder: (context, i) => const SizedBox(height: 8), 
                  itemCount: 6,
                  padding: const EdgeInsets.all(16),
                ),
                error: (error, stack) => MessageView(
                  icon: Icons.wifi_off,
                  text: 'Something went wrong',
                  action: FilledButton(
                    onPressed: ref.read(searchProvider.notifier).retry, 
                    child: const Text('Retry'),
                  ),
                ),
                data: (recipes) {
                  if (recipes.isEmpty) {
                    final hiddenByFilter = all.isNotEmpty;
                    return MessageView(
                      icon: Icons.search_off,
                      text: hiddenByFilter
                        ? 'No recipes match these filters'
                        : 'No recipes found',
                      action: hiddenByFilter
                        ? OutlinedButton(
                            onPressed: ref
                              .read(searchFilterProvider.notifier)
                              .clear, 
                            child: const Text('Clear Filter'),
                          )
                        : null,
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, i) => RecipeCard(recipe: recipes [i]), 
                    separatorBuilder: (context, i) => const SizedBox(height: 8), 
                    itemCount: recipes.length,
                  );
                }
              )
          )
        ],
      ),
    );
  }
}

class _FilterBar extends ConsumerWidget {
  const _FilterBar({required this.categories, required this.areas});

  final List<String> categories;
  final List<String> areas;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (categories.length < 2 && areas.length < 2) {
      return const SizedBox.shrink();
    }

    final filter = ref.watch(searchFilterProvider);
    final notifier = ref.read(searchFilterProvider.notifier);

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          for (final c in categories) 
            Padding(
              padding: const EdgeInsetsGeometry.only(right: 8),
              child: FilterChip(
                label: Text(c), 
                selected: filter.category == c,
                onSelected: (_) => notifier.toggleCategory(c),
              ),
            ),
          for (final a in areas) 
            Padding(
              padding: const EdgeInsetsGeometry.only(right: 8),
              child: FilterChip(
                label: Text(a), 
                selected: filter.category == a,
                onSelected: (_) => notifier.toggleArea(a),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecentSearches extends ConsumerWidget {
  const _RecentSearches({required this.onPick});

  final void Function(String query) onPick;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recents = ref.watch(recentSearchProvider).value ?? const<String> [];
    final notifier = ref.read(recentSearchProvider.notifier);
    
    if (recents.isEmpty) {
      return const MessageView(
        icon: Icons.restaurant_menu, 
        text: 'Type a recipe name',
      );
    }
    return ListView(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(16, 8, 8, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Recent searches',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              TextButton(onPressed: notifier.clear, child: const Text('Clear')),
            ],
          ),
        ),
        for (final query in recents)
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(query),
            trailing: IconButton(
              onPressed: () => notifier.remove(query), 
              icon: const Icon(Icons.close),
              tooltip: 'Remove',
            ),
            onTap: () => onPick(query),
          ),
      ],
    );
  }
}