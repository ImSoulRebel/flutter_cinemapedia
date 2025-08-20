import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_cinemapedia/presentation/widgets/shared/loading_view.dart';
import 'package:flutter_cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  static const name = 'home-view';

  const HomeView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialMoviesLoadingProvider);

    if (initialLoading) {
      return LoadingView();
    }

    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(floating: true, flexibleSpace: CustomAppbar()),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: moviesSlideshow),
                MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: 'Esta semana',
                  loadNextPage:
                      () =>
                          ref
                              .read(nowPlayingMoviesProvider.notifier)
                              .loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage:
                      () =>
                          ref
                              .read(popularMoviesProvider.notifier)
                              .loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor valoradas',
                  loadNextPage:
                      () =>
                          ref
                              .read(topRatedMoviesProvider.notifier)
                              .loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  loadNextPage:
                      () =>
                          ref
                              .read(upcomingMoviesProvider.notifier)
                              .loadNextPage(),
                ),
                SizedBox(height: 10),
              ],
            );
          }, childCount: 1),
        ),

        // Expanded(
        //   child: ListView.builder(
        //     itemCount: nowPlayingMovies.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       final movie = nowPlayingMovies[index];
        //       return ListTile(title: Text(movie.title));
        //     },
        //   ),
        // ),
      ],
    );
  }
}
