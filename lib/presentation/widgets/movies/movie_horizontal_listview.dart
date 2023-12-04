import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_release/config/helpers/human_formats.dart';

import '../../../domain/entities/movie.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;
  const MovieHorizontalListView({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        print('Load next page');

        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      child: Column(children: [
        if (widget.title != null || widget.subTitle != null)
          _Title(
            title: widget.title,
            subTitle: widget.subTitle,
          ),
        Expanded(
            child: ListView.builder(
          controller: scrollController,
          itemCount: widget.movies.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => _Slide(movie: widget.movies[index]),
        )),
      ]),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          if (title != null) Text(title!, style: textStyle),
          const Spacer(),
          if (title != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(title!, style: textStyle),
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //Image
        SizedBox(
          width: 150.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              width: 150.0,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2.0));
                }
                return FadeIn(child: child);
              },
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        //Title
        SizedBox(
          width: 150.0,
          child: Text(movie.title, maxLines: 2, style: textStyle.titleSmall),
        ),
        SizedBox(
          width: 150.0,
          child: Row(
            children: [
              Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
              const SizedBox(width: 5.0),
              Text('${movie.voteAvarage}',
                  style: textStyle.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800)),
              const Spacer(),
              Text(HumanFormats.number(movie.popularity),
                  style: textStyle.bodySmall),
            ],
          ),
        )
      ]),
    );
  }
}
