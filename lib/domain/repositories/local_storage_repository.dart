import '../entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavourite(Movie movie);
  Future<bool> isMovieFavourite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
