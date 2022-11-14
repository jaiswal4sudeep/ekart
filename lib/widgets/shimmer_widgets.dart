
import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    Key? key,
    required this.width,
    required this.height,
    this.radius = 5,
  }) : super(key: key);
  final double width;
  final double height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppConstant.secondaryColor,
          borderRadius: BorderRadius.circular(radius!),
        ),
      ),
    );
  }
}


class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ShimmerContainer(
          width: 35.h,
          height: 35.h,
          radius: 200,
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: ShimmerContainer(
            width: 100.w,
            height: 15.h,
          ),
        ),
        subtitle: Align(
          alignment: Alignment.centerLeft,
          child: ShimmerContainer(
            width: 200.w,
            height: 12.h,
          ),
        ),
      ),
    );
  }
}


class ShimmerGridTile extends StatelessWidget {
  const ShimmerGridTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShimmerContainer(
              width: 60.h,
              height: 60.h,
              radius: 200,
            ),
            SizedBox(
              height: 10.h,
            ),
            ShimmerContainer(
              width: 70.w,
              height: 15.h,
            ),
            SizedBox(
              height: 5.h,
            ),
            ShimmerContainer(
              width: 140.w,
              height: 13.h,
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerContainer(
                    width: 50.w,
                    height: 15.h,
                  ),
                  ShimmerContainer(
                    width: 50.w,
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
