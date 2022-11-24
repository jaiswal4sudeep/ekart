import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    Key? key,
    required this.image,
    required this.index,
    required this.id,
    required this.onPressed,
  }) : super(key: key);
  final String image;
  final int index;
  final int id;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          highlightColor: AppConstant.transparent,
          splashColor: AppConstant.transparent,
          icon: ImageIcon(
            AssetImage(image),
            size: index == id ? 20.sp : 18.sp,
            color: index == id
                ? AppConstant.primaryColor
                : AppConstant.subtitlecolor,
          ),
        ),
      ],
    );
  }
}
