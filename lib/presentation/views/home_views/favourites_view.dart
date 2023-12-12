import 'package:flutter/material.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class FavouriteView extends ConsumerStatefulWidget {
  const FavouriteView({super.key});

  @override
  ConsumerState<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends ConsumerState<FavouriteView> {
  @override
  void initState() {
    super.initState();
    ref.read(favouriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favouriteMoviesProvider).values.toList();

    return Scaffold(body: MovieMasonry(movies: favoriteMovies));
  }
}
