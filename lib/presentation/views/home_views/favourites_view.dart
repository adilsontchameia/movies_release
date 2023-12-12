import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class FavouriteView extends ConsumerStatefulWidget {
  const FavouriteView({super.key});

  @override
  ConsumerState<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends ConsumerState<FavouriteView> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favouriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favouriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
          Text(
            'Ohh nooo...!',
            style: TextStyle(fontSize: 30.0, color: colors.primary),
          ),
          const Text(
            'No favorites movies saved...',
            style: TextStyle(fontSize: 20.0, color: Colors.black45),
          ),
          const SizedBox(height: 20.0),
          FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: const Text('See all movies'))
        ],
      ));
    }
    return Scaffold(
        body: MovieMasonry(
      movies: favoriteMovies,
    ));
  }
}
