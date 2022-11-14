import 'package:ekart/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardLoadingScreen extends StatelessWidget {
  const DashboardLoadingScreen({
    Key? key,
  }) : super(key: key);

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
        actions: [
          Center(
            child: ShimmerContainer(
              width: 20.w,
              height: 22.h,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Center(
            child: ShimmerContainer(
              width: 20.w,
              height: 22.h,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Center(
            child: ShimmerContainer(
              width: 20.w,
              height: 22.h,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ShimmerContainer(
                      width: 60.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    ShimmerContainer(
                      width: 60.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    ShimmerContainer(
                      width: 60.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    ShimmerContainer(
                      width: 60.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    ShimmerContainer(
                      width: 60.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    ShimmerContainer(
                      width: 60.w,
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    ShimmerContainer(
                      width: 60.w,
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 200.sp / 220.sp,
                crossAxisSpacing: 8.sp,
                mainAxisSpacing: 8.sp,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ShimmerGridTile();
              },
            ),
          ],
        ),
      ),
    );
  }
}
