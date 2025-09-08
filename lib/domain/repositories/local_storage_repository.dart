import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavourite(MovieEntity movie);
  Future<bool> isMovieFavourite(int movieId);
  Future<List<MovieEntity>> getFavouritesMovies({
    int limit = 10,
    int offset = 0,
  });
}
