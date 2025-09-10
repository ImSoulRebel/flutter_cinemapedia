import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/config/constants/slide_style.dart';
import 'package:flutter_cinemapedia/config/helpers/human_format.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/presentation/presentation.dart';
import 'package:go_router/go_router.dart';

class MoviesHorizontalListview extends StatelessWidget {
  final List<MovieEntity> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 350,
        child: Column(
          spacing: 8,
          children: [
            if (title != null && title!.isNotEmpty)
              _LeadingLabel(title: title!, subtitle: subtitle),
            Expanded(
              child: _HorizontalListview(
                movies: movies,
                loadNextPage: loadNextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HorizontalListview extends StatefulWidget {
  final List<MovieEntity> movies;
  final VoidCallback? loadNextPage;
  const _HorizontalListview({required this.movies, this.loadNextPage});

  @override
  State<_HorizontalListview> createState() => _HorizontalListviewState();
}

class _HorizontalListviewState extends State<_HorizontalListview> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (widget.loadNextPage != null) {
        if (controller.position.pixels + 200 >=
            controller.position.maxScrollExtent) {
          widget.loadNextPage!();
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.movies.length,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      controller: controller,
      itemBuilder:
          (BuildContext context, int index) =>
              _Slide(movie: widget.movies[index]),
    );
  }
}

class _Slide extends StatelessWidget {
  final MovieEntity movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return SlideStyle.slideLoading;
                  }
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: child,
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text(movie.title, maxLines: 2, style: textStyle.titleSmall),
            Row(
              spacing: 4,
              children: [
                MoviesRating(voteAverage: movie.voteAverage),
                Spacer(),
                Text(
                  HumanFormat.number(movie.popularity),
                  style: textStyle.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LeadingLabel extends StatelessWidget {
  final String title;
  final String? subtitle;
  const _LeadingLabel({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(title, style: titleStyle),
          Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              onPressed: () {},
              style: ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}
