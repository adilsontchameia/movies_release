import 'package:movies_release/domain/datasources/actors_datasource.dart';

import '../../domain/entities/actor.dart';
import '../../domain/repositories/actor_repositories.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);
  @override
  Future<List<Actor>> getActorByMovie(String movieId) {
    return datasource.getActorByMovie(movieId);
  }
}
