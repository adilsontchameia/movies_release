import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import 'widgets/movie_search_item.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  SearchMoviesCallback searchMovies;
  final List<Movie> initialMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      debounceMovies.add(movies);
    });
  }

  void clearStreams() {
    debounceMovies.close();
  }

  @override
  String get searchFieldLabel => 'Search movie';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: Icon(Icons.adaptive.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final List<Movie> movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ((context, index) {
            return MovieSearchItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          }),
        );
      },
    );
  }
}
