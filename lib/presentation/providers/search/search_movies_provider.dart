import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMoviesQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<MovieEntity>>((ref) {
      final moviesRepository = ref.read(moviesRepositoryProvider);

      return SearchedMoviesNotifier(
        ref,
        searchMoviesCallback: moviesRepository.getSearchMovies,
      );
    });

typedef SearchMoviesCallback = Future<List<MovieEntity>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<MovieEntity>> {
  final SearchMoviesCallback searchMoviesCallback;
  final Ref ref;

  SearchedMoviesNotifier(this.ref, {required this.searchMoviesCallback})
    : super([]);

  Future<List<MovieEntity>> searchMoviesByQuery(String query) async {
    final List<MovieEntity> movies = await searchMoviesCallback(query);
    ref.read(searchMoviesQueryProvider.notifier).update((state) => query);
    state = movies;

    return movies;
  }
}
