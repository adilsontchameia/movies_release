import '../entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorByMovie(String movieId);
}
