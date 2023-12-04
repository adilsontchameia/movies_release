import '../../config/constants/app_constants.dart';
import '../../domain/entities/movie.dart';
import '../models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDb movieDb) => Movie(
        adult: movieDb.adult,
        // ignore: unnecessary_null_comparison
        backdropPath: (movieDb.backdropPath != null)
            ? '${AppConstants.movieImageBaseUrl}/${movieDb.backdropPath}'
            : AppConstants.notFoundImageUrl,
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        // ignore: unnecessary_null_comparison
        posterPath: (movieDb.posterPath != null)
            ? '${AppConstants.movieImageBaseUrl}/${movieDb.posterPath}'
            : 'no-poster',
        releaseDate: movieDb.releaseDate,
        title: movieDb.title,
        video: movieDb.video,
        voteAvarage: movieDb.voteAvarage,
        voteCount: movieDb.voteCount,
      );
}
