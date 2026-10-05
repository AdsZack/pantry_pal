import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_pal/core/route/shell_scaffold.dart';
import 'package:pantry_pal/features/detail/presentation/detail_page.dart';
import 'package:pantry_pal/features/favorites/presentation/favorites_page.dart';
import 'package:pantry_pal/features/search/presentation/home_page.dart';
import 'package:pantry_pal/features/search/presentation/ingredient_results_page.dart';
import 'package:pantry_pal/features/search/presentation/results_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ShellScaffold(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (context, state) => const HomePage())
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/search', builder: (context, state) => const ResultsPage())
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/favorites', builder: (context, state) => const FavoritesPage())
          ]),
        ]
      ),
      // Opens on Top Bottom Navbar
      GoRoute(
        path: '/ingredient-results',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => IngredientResultsPage(),
      ),
      GoRoute(
        path: '/recipe/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => DetailPage(id: state.pathParameters['id']!),
      ),
    ]
  );
});