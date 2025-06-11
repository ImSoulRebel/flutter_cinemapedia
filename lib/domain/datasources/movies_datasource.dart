import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';

/// No queremos crear instancias de nuestras fuentes de datos
abstract class MoviesDatasource {
  /// Definimos como deben lucir nuestros origenes de datos
  Future<List<MovieEntity>> getNowPlaying({int page = 1});
}
