import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  static const name = 'movie-detail-screen';
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailProvider.notifier).loadMovieDetail(widget.movieId);
    ref
        .read(actorsByMovieIdProvider.notifier)
        .loadActorsByMovieId(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final MovieEntity? movieDetail =
        ref.watch(movieDetailProvider)[widget.movieId];

    return Scaffold(
      body:
          movieDetail == null
              ? LoadingView()
              : CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  _CustomSliverAppbar(movieDetail),
                  _CustomSliverDetail(movieDetail),
                ],
              ),
    );
  }
}

class _CustomSliverDetail extends StatelessWidget {
  final MovieEntity movieDetail;
  const _CustomSliverDetail(this.movieDetail);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitleAndOverview(movieDetail: movieDetail, textStyle: textStyle),
            _MovieGenres(movieDetail: movieDetail),
            _ActorsByMovieListview(movieDetail.id),
            VideosFromMovie(movieId: movieDetail.id),
            SimilarMovies(movieId: movieDetail.id),
          ],
        );
      }, childCount: 1),
    );
  }
}

class _MovieGenres extends StatelessWidget {
  const _MovieGenres({required this.movieDetail});

  final MovieEntity movieDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Wrap(
        spacing: 10,
        children: [
          ...movieDetail.genreIds.map(
            (genre) => Chip(
              label: Text(genre),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({required this.movieDetail, required this.textStyle});

  final MovieEntity movieDetail;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Imagen
          Flexible(
            flex: 1,
            child: Hero(
              tag: movieDetail.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movieDetail.posterPath,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/no-image.jpg',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),

          /// Descripción
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(movieDetail.title, style: textStyle.titleMedium),
                Text(movieDetail.overview),
                MoviesRating(voteAverage: movieDetail.voteAverage),
                MoviesReleaseDate(movieDetail: movieDetail),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActorsByMovieListview extends ConsumerWidget {
  final int movieId;
  const _ActorsByMovieListview(this.movieId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovieId = ref.watch(actorsByMovieIdProvider);

    final actors = actorsByMovieId["$movieId"];

    return actors != null
        ? SizedBox(
          height: 300,

          child: ListView.builder(
            itemCount: actors.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final actor = actors[index];
              return Container(
                padding: EdgeInsets.all(8),
                width: 135,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        actor.profilePath,
                        height: 180,
                        width: 135,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/no-image.jpg',
                            height: 180,
                            width: 135,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    Text(actor.name),
                    Text(
                      actor.character ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
        : Center(child: CircularProgressIndicator());
  }
}

class _CustomSliverAppbar extends ConsumerWidget {
  final MovieEntity movie;
  const _CustomSliverAppbar(this.movie);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final isFavouriteAsync = ref.watch(
      localStorageisFavouriteMovieProvider(movie.id),
    );

    return SliverAppBar(
      floating: true,
      expandedHeight: size.height * 0.7,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favouriteMoviesProvider.notifier)
                .toggleFavourite(movie);

            /// invalidando el estado de este provider lo regresamos a su estado
            /// inicial obligando al rebuild
            ref.invalidate(localStorageisFavouriteMovieProvider(movie.id));
          },
          icon: isFavouriteAsync.when(
            data:
                (bool isFavourite) =>
                    isFavourite
                        ? Icon(Icons.favorite_outlined, color: Colors.red)
                        : Icon(Icons.favorite_border),
            loading: () => const CircularProgressIndicator(strokeWidth: 2),
            error: (_, _) => throw UnimplementedError(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: _CustomShadowGradient(
          gradient: _ShadowGradient.topToBottom,
          shadowColor: scaffoldBackgroundColor,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder:
                    (context, child, loadingProgress) =>
                        loadingProgress != null ? SizedBox() : child,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/no-image.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            // _CustomShadowGradient(),
            _CustomShadowGradient(
              gradient: _ShadowGradient.bottomLeftToTopRight,
            ),
            _CustomShadowGradient(
              gradient: _ShadowGradient.bottomRightToTopLeft,
            ),
          ],
        ),
      ),
    );
  }
}

enum _ShadowGradient {
  topToBottom,
  // bottomToTop,
  // leftToRight,
  // rightToLeft,
  // topLeftToBottomRight,
  // topRightToBottomLeft,
  bottomLeftToTopRight,
  bottomRightToTopLeft,
}

class _CustomShadowGradient extends StatelessWidget {
  final _ShadowGradient gradient;
  final Color shadowColor;

  const _CustomShadowGradient({
    this.gradient = _ShadowGradient.topToBottom,
    this.shadowColor = Colors.black87,
  });

  Gradient gradientResult() => switch (gradient) {
    _ShadowGradient.topToBottom => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.7, 1.0],
      colors: [Colors.transparent, shadowColor],
    ),
    _ShadowGradient.bottomLeftToTopRight => LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [0.8, 1.0],
      colors: [Colors.transparent, shadowColor],
    ),
    _ShadowGradient.bottomRightToTopLeft => LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      stops: [0.8, 1.0],
      colors: [Colors.transparent, shadowColor],
    ),
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: gradientResult()),
      ),
    );
  }
}
