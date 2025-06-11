import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';

/// Llaman al datasource
abstract class MoviesRepository {
  Future<List<MovieEntity>> getNowPlaying({int page = 1});
}
