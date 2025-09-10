import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/presentation/widgets/movies/movies_rating.dart';

typedef SearchMovieCallback = Future<List<MovieEntity>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<MovieEntity?> {
  final SearchMovieCallback searchMoviesCallback;
  List<MovieEntity> initialMovies;

  SearchMovieDelegate({
    required this.searchMoviesCallback,
    this.initialMovies = const [],
  });

  StreamController<List<MovieEntity>> debouncedMoviesStream =
      StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  /// Funcion para añadir un delay a la pulsación de teclas asi evitando
  /// llamadas innecesarias
  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMoviesCallback(query);
      initialMovies = movies;
      debouncedMoviesStream.add(movies);
      isLoadingStream.add(false);
    });
  }

  onDisposeStreams() => debouncedMoviesStream.close();

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder<bool>(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data ?? false) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SizedBox(
                width: 20,
                height: 20,
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          return
          // query es una palabra reservada del searchDelegate para la caja de busqueda
          query.isNotEmpty
              ? IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))
              : SizedBox.shrink();
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        onDisposeStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _buildResultsAndSuggestions();
  }

  StreamBuilder<List<MovieEntity>> _buildResultsAndSuggestions() {
    return StreamBuilder(
      // future: searchMovieCallback(query),
      initialData: initialMovies,
      stream: debouncedMoviesStream.stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<MovieEntity>> snapshot,
      ) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder:
              (BuildContext context, int index) => _MovieItem(
                movie: movies[index],
                movieSelected: (context, movie) {
                  onDisposeStreams();
                  close(context, movie);
                },
              ),
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final MovieEntity movie;
  final Function movieSelected;
  const _MovieItem({required this.movie, required this.movieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () => movieSelected(context, movie),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  height: 130,
                  fit: BoxFit.cover,
                  image: NetworkImage(movie.posterPath),
                  placeholder: const AssetImage(
                    'assets/loaders/bottle-loader.gif',
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  Text(
                    movie.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  MoviesRating(voteAverage: movie.voteAverage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
