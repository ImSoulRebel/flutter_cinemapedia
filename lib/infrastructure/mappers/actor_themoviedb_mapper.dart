import 'package:flutter_cinemapedia/domain/entities/actor_entity.dart';
import 'package:flutter_cinemapedia/infrastructure/models/themoviedb/credits_themoviedb_model.dart';

class ActorThemoviedbMapper {
  static ActorEntity castToActorEntity(Cast cast) => ActorEntity(
    id: cast.id,
    name: cast.name,
    profilePath:
        (cast.profilePath != null)
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://imgs.search.brave.com/9Q1bsYKqUhp7dfkwNXK7ikiKkXhBq19-ZWA3MLHQ2d8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9paDEu/cmVkYnViYmxlLm5l/dC9pbWFnZS4xMzQ5/NzQ4NzkyLjEwNjgv/ZnBvc3RlcixzbWFs/bCx3YWxsX3RleHR1/cmUsc3F1YXJlX3By/b2R1Y3QsNjAweDYw/MC51MS5qcGc',

    character: cast.character,
  );
}
