import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedIngredientsNotifier extends Notifier<List<String>> {
  static const maxItems = 5;

  @override
  List<String> build() => [];

  void add(String raw) {
    final name = raw.trim().toLowerCase();
    if (name.isEmpty || state.contains(name) || state.length >= maxItems) {
      return;
    }
  }

  void remove(String name) {
    state = state.where((e) => e != name).toList();
  }

  void clear() => state = [];
}

final selectedIngredientsProvider = 
  NotifierProvider<SelectedIngredientsNotifier, List<String>>(
    SelectedIngredientsNotifier.new,
);