import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessage() {
    final messages = <String>[
      'Loading All Movies',
      'Loading Populars Movies',
      'Loading Up Coming Movies',
      'Please wait, it\'s taking more time than expected 🥺',
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please wait...'),
          const SizedBox(height: 5.0),
          const CircularProgressIndicator(strokeWidth: 2.0),
          const SizedBox(height: 10.0),
          StreamBuilder(
            stream: getLoadingMessage(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
