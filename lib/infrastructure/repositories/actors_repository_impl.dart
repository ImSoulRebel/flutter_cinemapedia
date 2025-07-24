import 'package:flutter_cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:flutter_cinemapedia/domain/entities/actor_entity.dart';
import 'package:flutter_cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImpl(this.datasource);

  @override
  Future<List<ActorEntity>> getActorsByMovieId(String movieId) {
    return datasource.getActorsByMovieId(movieId);
  }
}
