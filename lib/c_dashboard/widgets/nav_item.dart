import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.selIndex,
    required this.imageName,
    required this.id,
  }) : super(key: key);

  final ValueNotifier<int> selIndex;
  final String imageName;
  final int id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35.sp,
      height: 35.sp,
      child: Center(
        child: Image.asset(
          selIndex.value == id
              ? 'assets/icons/${imageName}_active.png'
              : 'assets/icons/${imageName}_inactive.png',
          width: 25.sp,
          height: 25.sp,
          color: selIndex.value == id
              ? AppConstant.secondaryColor
              : AppConstant.subtitlecolor,
        ),
      ),
    );
  }
}
