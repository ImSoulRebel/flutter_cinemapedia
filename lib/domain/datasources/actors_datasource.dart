import 'package:flutter_cinemapedia/domain/entities/actor_entity.dart';

/// No queremos crear instancias de nuestras fuentes de datos
abstract class ActorsDatasource {
  /// Definimos como deben lucir nuestros origenes de datos
  Future<List<ActorEntity>> getActorsByMovieId(String movieId);
}
