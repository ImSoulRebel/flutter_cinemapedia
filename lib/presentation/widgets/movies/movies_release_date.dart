import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/config/helpers/human_format.dart';
import 'package:flutter_cinemapedia/domain/domain.dart';

class MoviesReleaseDate extends StatelessWidget {
  const MoviesReleaseDate({super.key, required this.movieDetail});

  final MovieEntity movieDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Estreno:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 5),
        Text(HumanFormat.shortDate(movieDetail.releaseDate)),
      ],
    );
  }
}
