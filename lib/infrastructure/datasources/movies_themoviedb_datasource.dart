import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/config/constants/environment.dart';
import 'package:flutter_cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/infrastructure/mappers/movie_themoviedb_mapper.dart';
import 'package:flutter_cinemapedia/infrastructure/models/models.dart';

class MoviesThemoviedbDatasource extends MoviesDatasource {
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
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async =>
      await moviesReqByPage('/movie/now_playing', page);

  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) async =>
      await moviesReqByPage('/movie/popular', page);

  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) async =>
      await moviesReqByPage('/movie/top_rated', page);

  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) async =>
      await moviesReqByPage('/movie/upcoming', page);

  @override
  Future<MovieEntity> getMovieById(String id) async =>
      movieReqById('/movie', id);

  Future<List<MovieEntity>> moviesReqByPage(
    String apiPath,
    int? page, {
    String? query,
  }) async {
    final res = await dio.get(
      apiPath,
      queryParameters: {'page': page, 'query': query},
    );

    final ThemoviedbResponse themoviedbResponse = ThemoviedbResponse.fromJson(
      res.data,
    );

    final List<MovieEntity> movies =
        themoviedbResponse.results
            .map((e) => MovieThemoviedbMapper.movieThemoviedbToEntity(e))
            .toList();

    return movies;
  }

  Future<MovieEntity> movieReqById(String apiPath, String id) async {
    final res = await dio.get('$apiPath/$id');

    if (res.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final movieDetailRes = MovieDetailsThemoviedbModel.fromJson(res.data);

    final MovieEntity movieDetail =
        MovieThemoviedbMapper.movieDetailThemoviedbToEntity(movieDetailRes);

    return movieDetail;
  }

  @override
  Future<List<MovieEntity>> getSearchMovies(String query) =>
      moviesReqByPage('/search/movie', 1, query: query);
}
