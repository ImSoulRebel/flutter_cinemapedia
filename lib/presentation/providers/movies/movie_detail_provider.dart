import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailProvider =
    StateNotifierProvider<MovieDetailProvider, Map<String, MovieEntity>>((ref) {
      final movieRepository = ref.watch(moviesRepositoryProvider);

      return MovieDetailProvider(getMovieDetail: movieRepository.getMovieById);
    });

typedef GetMovieDetailCallback = Future<MovieEntity> Function(String id);

class MovieDetailProvider extends StateNotifier<Map<String, MovieEntity>> {
  final GetMovieDetailCallback getMovieDetail;

  MovieDetailProvider({required this.getMovieDetail}) : super({});

  Future<void> loadMovieDetail(String id) async {
    if (state[id] == null) {
      final movieDetail = await getMovieDetail(id);
      state = {...state, id: movieDetail};
    }
  }
}
