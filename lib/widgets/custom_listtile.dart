import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.imagePath,
  }) : super(key: key);
  final Function() onTap;
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(
        imagePath,
        height: 20.sp,
        color: AppConstant.subtitlecolor,
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right_rounded,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
