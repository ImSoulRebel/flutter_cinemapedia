import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/config/constants/environment.dart';
import 'package:flutter_cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/infrastructure/mappers/movie_themoviedb_mapper.dart';
import 'package:flutter_cinemapedia/infrastructure/models/themoviedb/themoviedb_response.dart';

class ThemoviedbDatasource extends MoviesDatasource {
  /// Se configura aquí porque es propio de este Datasource
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.themovieDBKey,
        'language': Environment.defaultLanguage,
      },
    ),
  );

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {
    final res = await dio.get('/movie/now_playing');

    final ThemoviedbResponse themoviedbResponse = ThemoviedbResponse.fromJson(
      res.data,
    );

    final List<MovieEntity> movies =
        themoviedbResponse.results
            .map((e) => MovieThemoviedbMapper.movieThemoviedbToEntity(e))
            .toList();

    return movies;
  }
}
