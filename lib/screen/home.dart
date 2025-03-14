import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png',
        ),
      ],
    );
  }
}
