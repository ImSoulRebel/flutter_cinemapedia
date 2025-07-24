import 'package:flutter_cinemapedia/infrastructure/datasources/actors_themoviedb_datasource.dart';
import 'package:flutter_cinemapedia/infrastructure/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Solo lectura es inmutable
final actorsRepositoryProvider = Provider(
  (ref) => ActorsRepositoryImpl(ActorsThemoviedbDatasource()),
);
