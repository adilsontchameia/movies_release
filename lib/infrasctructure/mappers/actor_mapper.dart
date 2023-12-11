import '../../config/constants/app_constants.dart';
import '../../domain/entities/actor.dart';
import '../models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != ''
            ? '${AppConstants.movieImageBaseUrl}/${cast.profilePath}'
            : AppConstants.notFoundImageUrl,
        character: cast.character,
      );
}
