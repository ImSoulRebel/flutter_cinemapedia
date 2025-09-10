import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/config/helpers/human_format.dart';

class MoviesRating extends StatelessWidget {
  final double voteAverage;

  const MoviesRating({super.key, required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      child: Row(
        children: [
          Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
          const SizedBox(width: 3),
          Text(
            HumanFormat.number(voteAverage, decimalDigits: 1),
            style: textStyles.bodyMedium?.copyWith(
              color: Colors.yellow.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
