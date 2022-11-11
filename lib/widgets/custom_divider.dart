import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 1.h,
        width: 0.5.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstant.backgroundColor,
              AppConstant.titlecolor.withOpacity(0.3),
              AppConstant.backgroundColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}
