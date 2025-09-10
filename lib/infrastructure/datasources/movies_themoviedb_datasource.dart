import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/config/constants/environment.dart';
import 'package:flutter_cinemapedia/domain/domain.dart';
import 'package:flutter_cinemapedia/infrastructure/infrastructure.dart';

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
    if (query != null && query.isEmpty) {
      return [];
    }

    final res = await dio.get(
      apiPath,
      queryParameters: {'page': page, 'query': query},
    );

    return _jsonToMovies(res.data);
  }

  List<MovieEntity> _jsonToMovies(Map<String, dynamic> json) {
    final ThemoviedbResponse themoviedbResponse = ThemoviedbResponse.fromJson(
      json,
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

  @override
  Future<List<MovieEntity>> getSimilarMovies(int movieId) async {
    final response = await dio.get('/movie/$movieId/similar');
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<VideoEntity>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);
    final videos = <VideoEntity>[];

    for (final moviedbVideo in moviedbVideosReponse.results) {
      if (moviedbVideo.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(moviedbVideo);
        videos.add(video);
      }
    }

    return videos;
  }
}
