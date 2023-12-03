import '../entities/movie.dart';

abstract class MoveRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
