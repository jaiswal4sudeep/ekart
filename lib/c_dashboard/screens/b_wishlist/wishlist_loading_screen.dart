import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';

class WishlistLoadingScreen extends StatelessWidget {
  const WishlistLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
        ),
        leading: const BackScreenButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return const ShimmerListTile();
          },
        ),
      ),
    );
  }
}
