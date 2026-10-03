import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_pal/core/utils/debauncher.dart';
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

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchProvider);
    final notifier = ref.read(searchProvider.notifier);

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
                    notifier.search('');
                  },
                  icon: const Icon(Icons.close),
                )
              ),
              onChanged: (q) => _debouncher.run(() => notifier.search(q)),
              onSubmitted: notifier.search,
            ),
          ),
          Expanded(
            child: results.when(
              loading: () => ListView.separated(
                itemBuilder: (context, i) => const RecipeCardSkeleton(), 
                separatorBuilder: (context, i) => const SizedBox(height: 8), 
                itemCount: 6,
                padding: const EdgeInsets.all(16),
              ),
              error: (error, stack) => _Message(
                icon: Icons.wifi_off,
                text: 'Something went wrong',
                action: FilledButton(
                  onPressed: notifier.retry, 
                  child: const Text('Retry'),
                ),
              ),
              data: (recipes) {
                if (recipes.isEmpty) {
                  final typed = _controller.text.trim().isNotEmpty;
                  return _Message(
                    icon: typed ? Icons.search_off : Icons.restaurant_menu, 
                    text: typed ? 'No recipes found' : 'Type recipe name',
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

class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.text, this.action});

  final IconData icon;
  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(icon, size: 48),
          const SizedBox(height: 12),
          Text(text),
          if (action != null) ...[const SizedBox(height: 16), action!],
        ],
      ),
    );
  }
}