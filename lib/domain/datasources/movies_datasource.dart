import 'package:flutter_cinemapedia/domain/domain.dart';

/// No queremos crear instancias de nuestras fuentes de datos
abstract class MoviesDatasource {
  /// Definimos como deben lucir nuestros origenes de datos
  Future<List<MovieEntity>> getNowPlaying({int page = 1});
  Future<List<MovieEntity>> getPopular({int page = 1});
  Future<List<MovieEntity>> getTopRated({int page = 1});
  Future<List<MovieEntity>> getUpcoming({int page = 1});
  Future<MovieEntity> getMovieById(String id);
  Future<List<MovieEntity>> getSearchMovies(String query);
  Future<List<MovieEntity>> getSimilarMovies(int movieId);
  Future<List<VideoEntity>> getYoutubeVideosById(int movieId);
}
