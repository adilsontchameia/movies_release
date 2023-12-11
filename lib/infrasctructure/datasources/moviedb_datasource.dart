import '../../config/constants/app_constants.dart';
import '../../domain/datasources/movies_datasource.dart';
import '../../presentation/providers/providers.dart';
import '../mappers/movie_mapper.dart';
import '../models/moviedb/movie_details.dart';
import '../models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        //Where: Avoid show movies that has no posts
        .where((movieDb) => movieDb.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await AppConstants.dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await AppConstants.dio.get(
      '/movie/popular',
      queryParameters: {
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await AppConstants.dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await AppConstants.dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieByID(String id) async {
    final response = await AppConstants.dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response = await AppConstants.dio
        .get('/search/movie', queryParameters: {'query': query});
    return _jsonToMovies(response.data);
  }
}
