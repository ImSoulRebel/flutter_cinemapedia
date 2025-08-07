import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter_cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter_cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    final moviesRepository = ref.read(moviesRepositoryProvider);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            spacing: 8,
            children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.search),
                onPressed:
                    () => showSearch<MovieEntity?>(
                      context: context,
                      delegate: SearchMovieDelegate(
                        searchMovieCallback: moviesRepository.getSearchMovies,
                      ),
                    ).then((movie) {
                      if (movie != null && context.mounted) {
                        context.push('/movie/${movie.id}');
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
