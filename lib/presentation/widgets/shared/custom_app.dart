import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../screens/delegates/search_movie_delegate.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary),
              const SizedBox(width: 5.0),
              Text('Movies Release', style: titleStyle),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    final movieRepository = ref.read(movieRepositoryProvider);
                    showSearch(
                        context: context,
                        delegate: SearchMovieDelegate(
                          searchMovies: movieRepository.searchMovies,
                        ));
                  },
                  icon: const Icon(Icons.search)),
            ],
          ),
        ),
      ),
    );
  }
}
