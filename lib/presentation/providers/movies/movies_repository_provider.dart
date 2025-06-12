import 'package:flutter_cinemapedia/infrastructure/datasources/themoviedb_datasource.dart';
import 'package:flutter_cinemapedia/infrastructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Solo lectura es inmutable
final moviesRepositoryProvider = Provider(
  (ref) => MoviesRepositoryImpl(ThemoviedbDatasource()),
);
