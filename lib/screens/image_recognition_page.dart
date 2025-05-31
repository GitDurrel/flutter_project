import 'package:flutter/material.dart';

class ImageRecognitionPage extends StatelessWidget {
  const ImageRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reconnaissance image"),
      ),
      body: const Center(
        child: Text("Reconnaissance image Page"),
      ),
    );
  }
}
