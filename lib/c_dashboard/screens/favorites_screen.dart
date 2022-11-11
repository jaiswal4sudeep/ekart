import 'package:ekart/widgets/back_screen_button.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Items',
        ),
        leading: const BackScreenButton(),
      ),
    );
  }
}
