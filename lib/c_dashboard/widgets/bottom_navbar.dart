
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ekart/c_dashboard/widgets/nav_item.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.bottomNavigationKey,
    required this.selIndex,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> bottomNavigationKey;
  final ValueNotifier<int> selIndex;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: bottomNavigationKey,
      index: selIndex.value,
      height: 60.0,
      items: <Widget>[
        NavItem(
          selIndex: selIndex,
          imageName: 'home',
          id: 0,
        ),
        NavItem(
          selIndex: selIndex,
          imageName: 'wishlist',
          id: 1,
        ),
        NavItem(
          selIndex: selIndex,
          imageName: 'cart',
          id: 2,
        ),
        NavItem(
          selIndex: selIndex,
          imageName: 'delivery',
          id: 3,
        ),
        NavItem(
          selIndex: selIndex,
          imageName: 'profile',
          id: 4,
        ),
      ],
      buttonBackgroundColor: AppConstant.primaryColor,
      color: AppConstant.secondaryColor,
      backgroundColor: AppConstant.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (index) {
        selIndex.value = index;
      },
      letIndexChange: (index) => true,
    );
  }
}
