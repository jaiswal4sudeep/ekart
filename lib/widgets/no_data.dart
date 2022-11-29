import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Image.asset(
            'assets/icons/no_data.png',
            height: 150.h,
          ),
          SizedBox(
            height: 20.h,
          ),
          const TextStyle5(content: 'No items available')
        ],
      ),
    );
  }
}

class ImageErrorBuilder extends StatelessWidget {
  const ImageErrorBuilder({
    Key? key,
    this.containerW = 70,
    this.containerH = 70,
    this.imageSize = 40,
  }) : super(key: key);

  final double containerW;
  final double containerH;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerW.h,
      height: containerH.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300]!,
      ),
      child: Center(
        child: Image.asset(
          'assets/icons/error.png',
          width: imageSize.sp,
          color: AppConstant.subtitlecolor,
        ),
      ),
    );
  }
}
