import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/domain/domain.dart';
import 'package:flutter_cinemapedia/presentation/presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final FutureProviderFamily<List<VideoEntity>, int> videosFromMovieProvider =
    FutureProvider.family((ref, int movieId) {
      final movieRepository = ref.watch(moviesRepositoryProvider);
      return movieRepository.getYoutubeVideosById(movieId);
    });

class VideosFromMovie extends ConsumerWidget {
  final int movieId;

  const VideosFromMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesFromVideo = ref.watch(videosFromMovieProvider(movieId));

    return moviesFromVideo.when(
      data: (videos) => _VideosList(videos: videos),
      error:
          (_, _) => const Center(
            child: Text('No se pudo cargar películas similares'),
          ),
      loading:
          () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _VideosList extends StatelessWidget {
  final List<VideoEntity> videos;

  const _VideosList({required this.videos});

  @override
  Widget build(BuildContext context) {
    //* Nada que mostrar
    if (videos.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            'Videos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        //* Ejemplo de imagen con manejo de error
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Image.network(
            'https://image.tmdb.org/t/p/w500/ccq2QyASGGltklwtCH0aBgM8whT.jpg',
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/no-image.jpg',
                height: 200,
                fit: BoxFit.cover,
              );
            },
            height: 200,
            fit: BoxFit.cover,
          ),
        ),

        //* Aunque tengo varios videos, sólo quiero mostrar el primero
        _YouTubeVideoPlayer(
          youtubeId: videos.first.youtubeKey,
          name: videos.first.name,
        ),

        //* Si se desean mostrar todos los videos
        // ...videos.map(
        //   (video) => _YouTubeVideoPlayer(youtubeId: videos.first.youtubeKey, name: video.name)
        // ).toList()
      ],
    );
  }
}

class _YouTubeVideoPlayer extends StatefulWidget {
  final String youtubeId;
  final String name;

  const _YouTubeVideoPlayer({required this.youtubeId, required this.name});

  @override
  State<_YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(widget.name), YoutubePlayer(controller: _controller)],
      ),
    );
  }
}
