import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/helpers/human_formats.dart';
import '../../../domain/entities/movie.dart';

class MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const MovieSearchItem(
      {super.key, required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
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
      ),
    );
  }
}
