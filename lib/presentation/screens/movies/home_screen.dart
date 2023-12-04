import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_release/presentation/providers/movies/movies_provider.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideshowProvider);
    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideShow(movies: moviesSlideShow),
        MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: 'In Theater',
            subTitle: 'Monday 05',
            loadNextPage: () =>
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),
      ],
    );
  }
}
