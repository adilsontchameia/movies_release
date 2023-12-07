import 'package:movies_release/domain/entities/actor.dart';

import '../../config/constants/app_constants.dart';
import '../../domain/datasources/actors_datasource.dart';
import '../mappers/actor_mapper.dart';
import '../models/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await AppConstants.dio.get('/movie/$movieId/credits');
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $movieId not found');
    }

    final castReponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors =
        castReponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();

    return actors;
  }
}
