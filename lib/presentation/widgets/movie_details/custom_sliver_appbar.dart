import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';
import '../widgets.dart';

class CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const CustomSliverAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
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
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1.0],
              colors: [Colors.transparent, Colors.black87],
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
