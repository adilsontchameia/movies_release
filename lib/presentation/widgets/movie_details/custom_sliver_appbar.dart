import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../providers/providers.dart';
import '../widgets.dart';

final isFavouriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  //First needs to query in db
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return localStorageRepository.isMovieFavourite(movieId); //if its in favourite
});

class CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const CustomSliverAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.sizeOf(context);

    final isFavouriteFuture = ref.watch(isFavouriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {
              ref.watch(localStorageRepositoryProvider).toggleFavourite(movie);
              ref.invalidate(isFavouriteProvider(movie.id));
            },
            icon: isFavouriteFuture.when(
              data: (isFavourite) => isFavourite
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border),
              error: (_, __) => throw UnimplementedError(),
              loading: () => const CircularProgressIndicator(strokeWidth: 2),
            ))
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        /*
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20.0),
          textAlign: TextAlign.start,
        ),
        */
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black54, Colors.transparent],
            ),
            const CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.3],
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
