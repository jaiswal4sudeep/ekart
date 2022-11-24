import 'package:ekart/c_dashboard/widgets/bottom_nav_painter.dart';
import 'package:ekart/c_dashboard/widgets/navbar_icon.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardBottomNavbar extends HookWidget {
  const DashboardBottomNavbar({
    Key? key,
    required this.selIndex,
  }) : super(key: key);
  final ValueNotifier<int> selIndex;
  @override
  Widget build(BuildContext context) {
    double height = 56;

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(1.sw, height + 6),
            painter: BottomNavCurvePainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              backgroundColor: AppConstant.primaryColor,
              elevation: 0.1,
              onPressed: () {
                selIndex.value = 3;
              },
              child: const ImageIcon(
                AssetImage('assets/icons/cart.png'),
              ),
            ),
          ),
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavBarIcon(
                  image: 'assets/icons/home.png',
                  index: selIndex.value,
                  id: 1,
                  onPressed: () {
                    selIndex.value = 1;
                  },
                ),
                NavBarIcon(
                  image: 'assets/icons/wishlist.png',
                  index: selIndex.value,
                  id: 2,
                  onPressed: () {
                    selIndex.value = 2;
                  },
                ),
                const SizedBox(width: 56),
                NavBarIcon(
                  image: 'assets/icons/order-history.png',
                  index: selIndex.value,
                  id: 4,
                  onPressed: () {
                    selIndex.value = 4;
                  },
                ),
                NavBarIcon(
                  image: 'assets/icons/profile.png',
                  index: selIndex.value,
                  id: 5,
                  onPressed: () {
                    selIndex.value = 5;
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
