import 'package:flutter_cinemapedia/domain/domain.dart';
import 'package:flutter_cinemapedia/infrastructure/models/models.dart';

class VideoMapper {
  static VideoEntity moviedbVideoToEntity(Result moviedbVideo) => VideoEntity(
    id: moviedbVideo.id,
    name: moviedbVideo.name,
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt,
  );
}
