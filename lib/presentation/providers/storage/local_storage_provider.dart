import 'package:flutter_cinemapedia/infrastructure/datasources/drift_local_storage_datasource.dart';
import 'package:flutter_cinemapedia/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider(
  (ref) => LocalStorageRepositoryImpl(DriftLocalStorageDatasource()),
);

/// El [.family] permite recibir argumentos
final localStorageisFavouriteMovieProvider = FutureProvider.family.autoDispose((
  ref,
  int movieId,
) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavourite(movieId);
});
