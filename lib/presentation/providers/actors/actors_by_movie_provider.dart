import 'package:flutter_cinemapedia/domain/entities/actor_entity.dart';
import 'package:flutter_cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieIdProvider = StateNotifierProvider<
  ActorsByMovieIdNotifier,
  Map<String, List<ActorEntity>>
>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieIdNotifier(
    getActorsByMovieId: actorsRepository.getActorsByMovieId,
  );
});

typedef GetActorsByMovieIdCallback =
    Future<List<ActorEntity>> Function(String movieId);

class ActorsByMovieIdNotifier
    extends StateNotifier<Map<String, List<ActorEntity>>> {
  final GetActorsByMovieIdCallback getActorsByMovieId;

  ActorsByMovieIdNotifier({required this.getActorsByMovieId}) : super({});

  Future<void> loadActorsByMovieId(String movieId) async {
    if (state[movieId] == null) {
      final List<ActorEntity> actors = await getActorsByMovieId(movieId);
      state = {...state, movieId: actors};
    }
  }
}
