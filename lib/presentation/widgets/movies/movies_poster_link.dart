import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/domain/domain.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {
  final MovieEntity movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return FadeInUp(
      from: random.nextInt(100).toDouble() + 80,
      delay: Duration(milliseconds: 100 * (random.nextInt(5))),
      child: GestureDetector(
        onTap: () => context.push('/movie/${movie.id}'),
        child: Hero(
          tag: movie.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 180,
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
              image: NetworkImage(movie.posterPath),
            ),
          ),
        ),
      ),
    );
  }
}
