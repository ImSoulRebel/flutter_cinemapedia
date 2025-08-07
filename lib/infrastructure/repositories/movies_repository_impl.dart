import 'package:flutter_cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MoviesRepositoryImpl(this.datasource);

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) =>
      datasource.getNowPlaying(page: page);

  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) =>
      datasource.getPopular(page: page);

  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) =>
      datasource.getTopRated();

  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) =>
      datasource.getUpcoming();

  @override
  Future<MovieEntity> getMovieById(String id) => datasource.getMovieById(id);

  @override
  Future<List<MovieEntity>> getSearchMovies(String query) =>
      datasource.getSearchMovies(query);
}
