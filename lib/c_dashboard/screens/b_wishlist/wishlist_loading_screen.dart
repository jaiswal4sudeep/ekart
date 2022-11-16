import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
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
