import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshowProvider = Provider<List<MovieEntity>>((ref) {
  final movies = ref.watch(nowPlayingMoviesProvider);

  return movies.sublist(0, 6);
});
