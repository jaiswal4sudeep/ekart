import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.selIndex,
  }) : super(key: key);

  final ValueNotifier<int> selIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: AppConstant.secondaryColor,
      currentIndex: selIndex.value,
      elevation: 20,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            selIndex.value == 0
                ? 'assets/icons/home_active.png'
                : 'assets/icons/home_inactive.png',
            width: 25.sp,
            height: 25.sp,
            color: AppConstant.subtitlecolor,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            selIndex.value == 1
                ? 'assets/icons/wishlist_active.png'
                : 'assets/icons/wishlist_inactive.png',
            width: 20.sp,
            height: 20.sp,
            color: AppConstant.subtitlecolor,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            selIndex.value == 2
                ? 'assets/icons/cart_active.png'
                : 'assets/icons/cart_inactive.png',
            width: 30.sp,
            height: 30.sp,
            color: AppConstant.subtitlecolor,
          ),
          label: '',
        ),
      ],
      onTap: (index) {
        selIndex.value = index;
      },
    );
  }
}
