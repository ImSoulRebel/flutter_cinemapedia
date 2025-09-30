import 'package:drift/drift.dart' as drift;
import 'package:flutter_cinemapedia/config/database/database.dart';
import 'package:flutter_cinemapedia/domain/domain.dart';

class DriftLocalStorageDatasource extends LocalStorageDatasource {
  final AppDatabase _db;

  DriftLocalStorageDatasource([AppDatabase? db]) : _db = db ?? AppDatabase();

  @override
  Future<List<MovieEntity>> getFavouritesMovies({
    int limit = 10,
    int offset = 0,
  }) async {
    // Construye query
    final query = _db.select(_db.favoriteMovies)..limit(limit, offset: offset);

    // Ejecuta query
    final favoriteMovies = await query.get();

    // Convierte a MovieEntity y retorna
    return favoriteMovies
        .map(
          (favMovieRow) => MovieEntity(
            adult: false,
            backdropPath: favMovieRow.backdropPath ?? '',
            genreIds: const [],
            id: favMovieRow.movieId,
            originalLanguage: '',
            originalTitle: favMovieRow.originalTitle,
            overview: favMovieRow.overview ?? '',
            popularity: 0,
            posterPath: favMovieRow.posterPath ?? '',
            releaseDate:
                favMovieRow.releaseDate != null
                    ? DateTime.tryParse(favMovieRow.releaseDate!)
                    : null,
            title: favMovieRow.title,
            video: false,
            voteAverage: favMovieRow.voteAverage ?? 0.0,
            voteCount: 0,
          ),
        )
        .toList();
  }

  @override
  Future<bool> isMovieFavourite(int movieId) async {
    // Construye query
    final query = _db.select(_db.favoriteMovies)
      ..where((tbl) => tbl.movieId.equals(movieId));

    // Ejecuta query
    final favouriteMovie = await query.getSingleOrNull();

    // retorna resultado
    return favouriteMovie != null;
  }

  @override
  Future<void> toggleFavourite(MovieEntity movie) async {
    final isFavourite = await isMovieFavourite(movie.id);

    if (isFavourite) {
      // Si ya es favorito, eliminar de favoritos
      final deleteQuery = _db.delete(_db.favoriteMovies)
        ..where((tbl) => tbl.movieId.equals(movie.id));
      await deleteQuery.go();
    } else {
      // Si no es favorito, agregar a favoritos
      final newFavouriteMovie = FavoriteMoviesCompanion.insert(
        movieId: movie.id,
        title: movie.title,
        originalTitle: movie.originalTitle,
        posterPath: drift.Value(movie.posterPath),
        overview: drift.Value(movie.overview),
        releaseDate: drift.Value(movie.releaseDate?.toIso8601String()),
      );
      await _db.into(_db.favoriteMovies).insert(newFavouriteMovie);
    }
  }
}
