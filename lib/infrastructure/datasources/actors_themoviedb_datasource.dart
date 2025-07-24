import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/config/constants/environment.dart';
import 'package:flutter_cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:flutter_cinemapedia/domain/entities/actor_entity.dart';
import 'package:flutter_cinemapedia/infrastructure/mappers/actor_themoviedb_mapper.dart';
import 'package:flutter_cinemapedia/infrastructure/models/themoviedb/credits_themoviedb_model.dart';

class ActorsThemoviedbDatasource extends ActorsDatasource {
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
  Future<List<ActorEntity>> getActorsByMovieId(String movieId) async {
    final String apiPath = '/movie/$movieId/credits';
    final res = await dio.get(apiPath);
    final CreditsThemoviedbModel creditsresponse =
        CreditsThemoviedbModel.fromJson(res.data);

    final List<ActorEntity> actors =
        creditsresponse.cast.map((cast) {
          return ActorThemoviedbMapper.castToActorEntity(cast);
        }).toList();

    return actors;
  }
}
