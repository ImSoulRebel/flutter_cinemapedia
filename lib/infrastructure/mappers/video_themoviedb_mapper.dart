import 'package:flutter_cinemapedia/domain/domain.dart';
import 'package:flutter_cinemapedia/infrastructure/models/models.dart';

class VideoMapper {
  static moviedbVideoToEntity(Result moviedbVideo) => VideoEntity(
    id: moviedbVideo.id,
    name: moviedbVideo.name,
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt,
  );
}
