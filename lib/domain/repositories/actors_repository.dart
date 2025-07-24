import 'package:flutter_cinemapedia/domain/entities/actor_entity.dart';

abstract class ActorsRepository {
  Future<List<ActorEntity>> getActorsByMovieId(String movieId);
}
