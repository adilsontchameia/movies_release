import 'package:movies_release/domain/repositories/local_storage_repository.dart';
import 'package:movies_release/presentation/providers/providers.dart';

final favouriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
      offset: page * 10,
      limit: 20,
    );
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    //... => updating
    state = {...state, ...tempMoviesMap};
    return movies;
  }

  Future<void> toggleFavourite(Movie movie) async {
    await localStorageRepository.toggleFavourite(movie);
    final bool isMovieFavourite = state[movie.id] != null;
    if (isMovieFavourite) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
