import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:flutter_cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, MovieEntity>>((ref) {
      final localStoragerepository = ref.watch(localStorageRepositoryProvider);
      return StorageMoviesNotifier(localStoragerepository);
    });

class StorageMoviesNotifier extends StateNotifier<Map<int, MovieEntity>> {
  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier(this.localStorageRepository) : super({});

  int page = 0;

  Future<List<MovieEntity>> loadMovies() async {
    final favMovies = await localStorageRepository.getFavouritesMovies(
      offset: page * 10,
      limit: 20,
    );

    page++;

    final tempFavMoviesMap = <int, MovieEntity>{};
    for (final movie in favMovies) {
      tempFavMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempFavMoviesMap};

    return favMovies;
  }

  Future<void> toggleFavourite(MovieEntity movie) async {
    await localStorageRepository.toggleFavourite(movie);
    final isMovieInFavourites = state.containsKey(movie.id);

    if (isMovieInFavourites) {
      state = {...state}..remove(movie.id);
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
