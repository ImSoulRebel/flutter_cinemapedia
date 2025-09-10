import 'package:flutter_cinemapedia/domain/domain.dart';

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

  @override
  Future<List<MovieEntity>> getSimilarMovies(int movieId) =>
      datasource.getSimilarMovies(movieId);

  @override
  Future<List<VideoEntity>> getYoutubeVideosById(int movieId) =>
      datasource.getYoutubeVideosById(movieId);
}
