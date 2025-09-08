import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/domain/domain.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {
  final MovieEntity movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: Hero(
        tag: movie.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(movie.posterPath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
