import 'package:movies_release/domain/datasources/local_storage_datasource.dart';
import 'package:movies_release/domain/entities/movie.dart';
import 'package:movies_release/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);
  @override
  Future<bool> isMovieFavourite(int movieId) {
    return datasource.isMovieFavourite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavourite(Movie movie) {
    return datasource.toggleFavourite(movie);
  }
}
