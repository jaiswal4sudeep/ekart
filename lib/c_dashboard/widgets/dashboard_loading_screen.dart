import 'package:ekart/utils/app_constant.dart';
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
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        title: const Text(
          'EKart',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/heart.png',
              height: 18.sp,
              color: AppConstant.subtitlecolor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/shopping-cart.png',
              height: 18.sp,
              color: AppConstant.subtitlecolor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/search.png',
              height: 18.sp,
              color: AppConstant.subtitlecolor,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: ListView(
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
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ShimmerContainer(
                    width: 60.w,
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ShimmerContainer(
                    width: 60.w,
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ShimmerContainer(
                    width: 60.w,
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ShimmerContainer(
                    width: 60.w,
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ShimmerContainer(
                    width: 60.w,
                    height: 25.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  ShimmerContainer(
                    width: 60.w,
                    height: 25.h,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 200.sp / 230.sp,
                crossAxisSpacing: 4.sp,
                mainAxisSpacing: 4.sp,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ShimmerGridTile();
              },
            ),
          ),
        ],
      ),
    );
  }
}
