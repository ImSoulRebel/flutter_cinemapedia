import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int currentPage = 0;
typedef MoviesCallback = Future<List<MovieEntity>> Function({int page});

/// Casos de uso
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
      final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getNowPlaying;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
      final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getPopular;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
      final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getTopRated;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
      final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getUpcoming;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

class MoviesNotifier extends StateNotifier<List<MovieEntity>> {
  final MoviesCallback fetchMoreMovies;
  bool isLoading = false;
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (!isLoading) {
      isLoading = true;
      currentPage++;
      final List<MovieEntity> movies = await fetchMoreMovies(page: currentPage);
      state = [...state, ...movies];
      await Future.delayed(Duration(milliseconds: 300));
      isLoading = false;
    }
  }
}

final initialMoviesLoadingProvider = Provider<bool>((ref) {
  bool isLoading = false;

  final isNowPlayingMoviesIsLoading =
      ref.watch(nowPlayingMoviesProvider).isEmpty;
  final isPopularMoviesIsLoading = ref.watch(popularMoviesProvider).isEmpty;
  final isUpcomingMoviesIsLoading = ref.watch(upcomingMoviesProvider).isEmpty;
  final isTopRatedMoviesIsLoading = ref.watch(topRatedMoviesProvider).isEmpty;
  if (isNowPlayingMoviesIsLoading ||
      isPopularMoviesIsLoading ||
      isUpcomingMoviesIsLoading ||
      isTopRatedMoviesIsLoading) {
    isLoading = true;
  }

  return isLoading;
});
