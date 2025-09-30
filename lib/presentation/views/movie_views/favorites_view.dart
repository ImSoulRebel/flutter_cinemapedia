import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/presentation/providers/storage/favourite_movies_provider.dart';
import 'package:flutter_cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavouritesView extends ConsumerStatefulWidget {
  static const name = 'favourites-view';

  const FavouritesView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends ConsumerState<FavouritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final newMovies =
        await ref.read(favouriteMoviesProvider.notifier).loadMovies();
    isLoading = false;

    if (newMovies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favMovies = ref.watch(favouriteMoviesProvider).values.toList();

    if (favMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('No favourite movies yet'),
            SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go('/'),
              child: Text('Go to home'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MovieMasonry(movies: favMovies, loadNextPage: loadNextPage),
        ),
      ),
    );
  }
}
