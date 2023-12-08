import '../../config/constants/app_constants.dart';
import '../../domain/entities/movie.dart';
import '../models/moviedb/movie_details.dart';
import '../models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDb movieDb) => Movie(
        adult: movieDb.adult,
        // ignore: unnecessary_null_comparison
        backdropPath: (movieDb.backdropPath != '')
            ? '${AppConstants.movieImageBaseUrl}/${movieDb.backdropPath}'
            : AppConstants.notFoundImageUrl,
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        // ignore: unnecessary_null_comparison
        posterPath: (movieDb.posterPath != '')
            ? '${AppConstants.movieImageBaseUrl}/${movieDb.posterPath}'
            : AppConstants.notFoundImageUrl,
        releaseDate:
            movieDb.releaseDate != null ? movieDb.releaseDate! : DateTime.now(),
        title: movieDb.title,
        video: movieDb.video,
        voteAvarage: movieDb.voteAvarage,
        voteCount: movieDb.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movieDb) => Movie(
        adult: movieDb.adult,
        // ignore: unnecessary_null_comparison
        backdropPath: (movieDb.backdropPath != '')
            ? '${AppConstants.movieImageBaseUrl}/${movieDb.backdropPath}'
            : AppConstants.notFoundImageUrl,
        genreIds: movieDb.genres.map((e) => e.name).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        // ignore: unnecessary_null_comparison
        posterPath: (movieDb.posterPath != '')
            ? '${AppConstants.movieImageBaseUrl}/${movieDb.posterPath}'
            : AppConstants.notFoundImageUrl,
        releaseDate: movieDb.releaseDate,
        title: movieDb.title,
        video: movieDb.video,
        voteAvarage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
      );
}
