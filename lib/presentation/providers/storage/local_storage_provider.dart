import 'package:flutter_cinemapedia/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider(
  (ref) => LocalStorageRepositoryImpl(IsarLocalStorageDatasource()),
);

/// El [.family] permite recibir argumentos
final localStorageisFavouriteMovieProvider = FutureProvider.family.autoDispose((
  ref,
  int movieId,
) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavourite(movieId);
});
