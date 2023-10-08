import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin, end;
  final List<double> stops;
  final List<Color> colors;
  const CustomGradient({
    required this.begin,
    required this.end,
    required this.stops,
    required this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
      begin: begin,
      end: end,
      stops: stops,
      colors: colors,
    ))));
  }
}
