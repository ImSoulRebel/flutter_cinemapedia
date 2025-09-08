import 'package:flutter_cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<List<MovieEntity>> getFavouritesMovies({
    int limit = 10,
    int offset = 0,
  }) => datasource.getFavouritesMovies(limit: limit, offset: offset);

  @override
  Future<bool> isMovieFavourite(int movieId) =>
      datasource.isMovieFavourite(movieId);

  @override
  Future<void> toggleFavourite(MovieEntity movie) =>
      datasource.toggleFavourite(movie);
}
