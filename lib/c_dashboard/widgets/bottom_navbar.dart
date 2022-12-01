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
          icon: BottomNavIcon(
            selIndex: selIndex,
            icon: 'home',
            id: 0,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: BottomNavIcon(
            selIndex: selIndex,
            icon: 'wishlist',
            id: 1,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: BottomNavIcon(
            selIndex: selIndex,
            icon: 'cart',
            id: 2,
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

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    Key? key,
    required this.selIndex,
    required this.icon,
    required this.id,
  }) : super(key: key);

  final ValueNotifier<int> selIndex;
  final String icon;
  final int id;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 350);
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, anim) => ScaleTransition(
        scale: anim,
        child: child,
      ),
      child: Image.asset(
        selIndex.value == id
            ? 'assets/icons/${icon}_active.png'
            : 'assets/icons/${icon}_inactive.png',
        key: ValueKey(selIndex.value == id ? 'icon1' : 'icon2'),
        height: id == 0
            ? 25.sp
            : id == 1
                ? 20.sp
                : 30.sp,
        color: AppConstant.subtitlecolor,
      ),
    );
  }
}
