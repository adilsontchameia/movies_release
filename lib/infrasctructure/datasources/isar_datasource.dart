import 'package:movies_release/domain/datasources/local_storage_datasource.dart';
import 'package:movies_release/domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDatasource {
  @override
  Future<bool> isMovieFavourite(int movieId) {
    // TODO: implement isMovieFavourite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavourite(Movie movie) {
    // TODO: implement toggleFavourite
    throw UnimplementedError();
  }
}
