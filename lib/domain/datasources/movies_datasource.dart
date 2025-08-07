import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';

/// No queremos crear instancias de nuestras fuentes de datos
abstract class MoviesDatasource {
  /// Definimos como deben lucir nuestros origenes de datos
  Future<List<MovieEntity>> getNowPlaying({int page = 1});
  Future<List<MovieEntity>> getPopular({int page = 1});
  Future<List<MovieEntity>> getTopRated({int page = 1});
  Future<List<MovieEntity>> getUpcoming({int page = 1});
  Future<MovieEntity> getMovieById(String id);
  Future<List<MovieEntity>> getSearchMovies(String query);
}
