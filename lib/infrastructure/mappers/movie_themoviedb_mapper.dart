import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/infrastructure/models/models.dart';

/// Se encarga de leer modelos para transformarlos en entidades
class MovieThemoviedbMapper {
  static MovieEntity movieThemoviedbToEntity(
    MovieThemoviedbModel movieThemoviedbModel,
  ) => MovieEntity(
    adult: movieThemoviedbModel.adult,
    backdropPath:
        (movieThemoviedbModel.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieThemoviedbModel.backdropPath}'
            : 'https://imgs.search.brave.com/9Q1bsYKqUhp7dfkwNXK7ikiKkXhBq19-ZWA3MLHQ2d8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9paDEu/cmVkYnViYmxlLm5l/dC9pbWFnZS4xMzQ5/NzQ4NzkyLjEwNjgv/ZnBvc3RlcixzbWFs/bCx3YWxsX3RleHR1/cmUsc3F1YXJlX3By/b2R1Y3QsNjAweDYw/MC51MS5qcGc',
    genreIds: movieThemoviedbModel.genreIds.map((e) => e.toString()).toList(),
    id: movieThemoviedbModel.id,
    originalLanguage: movieThemoviedbModel.originalLanguage,
    originalTitle: movieThemoviedbModel.originalTitle,
    overview: movieThemoviedbModel.overview,
    popularity: movieThemoviedbModel.popularity,
    posterPath:
        (movieThemoviedbModel.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieThemoviedbModel.posterPath}'
            : 'https://imgs.search.brave.com/9Q1bsYKqUhp7dfkwNXK7ikiKkXhBq19-ZWA3MLHQ2d8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9paDEu/cmVkYnViYmxlLm5l/dC9pbWFnZS4xMzQ5/NzQ4NzkyLjEwNjgv/ZnBvc3RlcixzbWFs/bCx3YWxsX3RleHR1/cmUsc3F1YXJlX3By/b2R1Y3QsNjAweDYw/MC51MS5qcGc',
    releaseDate: movieThemoviedbModel.releaseDate,
    title: movieThemoviedbModel.title,
    video: movieThemoviedbModel.video,
    voteAverage: movieThemoviedbModel.voteAverage,
    voteCount: movieThemoviedbModel.voteCount,
  );

  static MovieEntity movieDetailThemoviedbToEntity(
    MovieDetailsThemoviedbModel movieDetailThemoviedbModel,
  ) => MovieEntity(
    adult: movieDetailThemoviedbModel.adult,
    backdropPath:
        (movieDetailThemoviedbModel.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDetailThemoviedbModel.backdropPath}'
            : 'https://imgs.search.brave.com/9Q1bsYKqUhp7dfkwNXK7ikiKkXhBq19-ZWA3MLHQ2d8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9paDEu/cmVkYnViYmxlLm5l/dC9pbWFnZS4xMzQ5/NzQ4NzkyLjEwNjgv/ZnBvc3RlcixzbWFs/bCx3YWxsX3RleHR1/cmUsc3F1YXJlX3By/b2R1Y3QsNjAweDYw/MC51MS5qcGc',
    genreIds: movieDetailThemoviedbModel.genres.map((e) => e.name).toList(),
    id: movieDetailThemoviedbModel.id,
    originalLanguage: movieDetailThemoviedbModel.originalLanguage,
    originalTitle: movieDetailThemoviedbModel.originalTitle,
    overview: movieDetailThemoviedbModel.overview,
    popularity: movieDetailThemoviedbModel.popularity,
    posterPath:
        (movieDetailThemoviedbModel.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDetailThemoviedbModel.posterPath}'
            : 'https://imgs.search.brave.com/9Q1bsYKqUhp7dfkwNXK7ikiKkXhBq19-ZWA3MLHQ2d8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9paDEu/cmVkYnViYmxlLm5l/dC9pbWFnZS4xMzQ5/NzQ4NzkyLjEwNjgv/ZnBvc3RlcixzbWFs/bCx3YWxsX3RleHR1/cmUsc3F1YXJlX3By/b2R1Y3QsNjAweDYw/MC51MS5qcGc',
    releaseDate: movieDetailThemoviedbModel.releaseDate,
    title: movieDetailThemoviedbModel.title,
    video: movieDetailThemoviedbModel.video,
    voteAverage: movieDetailThemoviedbModel.voteAverage,
    voteCount: movieDetailThemoviedbModel.voteCount,
  );
}
