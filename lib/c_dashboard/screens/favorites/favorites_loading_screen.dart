import 'package:ekart/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesLoadingScreen extends StatelessWidget {
  const FavoritesLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: ShimmerContainer(
            width: 30.w,
            height: 22.h,
          ),
        ),
        title: ShimmerContainer(
          width: 120.w,
          height: 22.h,
        ),
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
