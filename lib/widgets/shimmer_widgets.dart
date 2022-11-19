import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;

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
          borderRadius: BorderRadius.circular(200),
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
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ShimmerContainer(
              width: 50.w,
              height: 15.h,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ShimmerContainer(
            width: 70.h,
            height: 70.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          ShimmerContainer(
            width: 100.w,
            height: 15.h,
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
          SizedBox(
            height: 5.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ShimmerContainer(
                width: 50.w,
                height: 15.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
