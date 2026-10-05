import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pal/features/search/presentation/selected_ingredients_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _controller = TextEditingController();

  static const _suggestions = [
    'chicken',
    'egg',
    'rice',
    'onion',
    'garlic',
    'tomato',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _add(String raw) {
    final selected = ref.read(selectedIngredientsProvider);
    if (selected.length >= SelectedIngredientsNotifier.maxItems) {
      _snack('You can add up to ${SelectedIngredientsNotifier.maxItems} ingredients');
      return;
    }
  }

  void _find() {
    if (ref.read(selectedIngredientsProvider).isEmpty) {
      _snack('Add at least one ingredients');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(selectedIngredientsProvider);
    final textTheme = Theme.of(context).textTheme;
    final suggestions =
      _suggestions.where((s) => !selected.contains(s)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantry Pal'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("What's in your kitchen?", style: textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            'Add the ingredients you have and find recipes that use all of them.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Add an ingredient, e.r chicken',
              prefixIcon: const Icon(Icons.kitchen_outlined),
              suffixIcon: IconButton(
                onPressed: () => _add(_controller.text), 
                icon: const Icon(Icons.add),
                tooltip: 'Add ingredient',
              ),
            ),
            onSubmitted: _add,
          ),
          const SizedBox(height: 16),
          if (selected.isEmpty)
            Text('No ingredients yet.', style: textTheme.bodySmall)
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final name in selected)
                  InputChip(
                    label: Text(name),
                    onDeleted: () => ref
                      .read(selectedIngredientsProvider.notifier)
                      .remove(name),
                  ),
              ],
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _find, 
            icon: const Icon(Icons.search),
            label: const Text('Find recipes'),
          ),
          if (suggestions.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Quick add', style: textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in suggestions)
                  ActionChip(label: Text(s), onPressed: () => _add(s)),
              ],
            ),
          ],
        ],
      )
    );
  }
}