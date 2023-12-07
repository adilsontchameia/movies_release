import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_release/presentation/providers/providers.dart';

class ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const ActorsByMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }
    final actors = actorsByMovie[movieId]!;
    return SizedBox(
      height: 300.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (BuildContext context, int index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Actor photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      actor.profilePath,
                      height: 180.0,
                      width: 135.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //Actor name
                const SizedBox(height: 5.0),
                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
