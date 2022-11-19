import 'package:ekart/widgets/no_data.dart';
import 'package:ekart/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void zoomImage(String imagePath, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Image.network(
          imagePath,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return ShimmerContainer(
              width: 70.h,
              height: 70.h,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const ImageErrorBuilder();
          },
        ),
      );
    },
  );
}
