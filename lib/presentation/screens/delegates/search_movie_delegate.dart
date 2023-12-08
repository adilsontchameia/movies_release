import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_release/config/helpers/human_formats.dart';

import '../../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  SearchMoviesCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

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
      onPressed: () => close(context, null),
      icon: Icon(Icons.adaptive.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {
        final List<Movie> movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ((context, index) {
            return MovieSearchItem(movie: movies[index]);
          }),
        );
      },
    );
  }
}

class MovieSearchItem extends StatelessWidget {
  final Movie movie;
  const MovieSearchItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image
          FadeInLeft(
            child: SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(movie.posterPath),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          //Description
          FadeInRight(
            child: SizedBox(
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleMedium,
                    ),
                    (movie.overview.length > 100)
                        ? Text('${movie.overview.substring(0, 100)}...')
                        : Text(movie.overview),
                    const SizedBox(width: 5.0),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: Colors.yellow.shade800,
                        ),
                        Text(
                          HumanFormats.number(movie.voteAvarage, 1),
                          style: textStyle.bodyMedium!
                              .copyWith(color: Colors.yellow.shade800),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
