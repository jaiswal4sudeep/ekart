import 'package:ekart/b_authentication/authentication_controller.dart';
import 'package:ekart/b_authentication/authentication_screen.dart';
import 'package:ekart/c_dashboard/screens/b_wishlist/wishlist_screen.dart';
import 'package:ekart/c_dashboard/screens/cart_screen.dart';
import 'package:ekart/c_dashboard/screens/order_history_screen.dart';
import 'package:ekart/c_dashboard/screens/payment_details_screen.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_listtile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    Key? key,
    required this.appName,
    required this.appVersion,
    required this.userData,
    required this.user,
  }) : super(key: key);

  final String appName;
  final String appVersion;
  final dynamic userData;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppConstant.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              CircleAvatar(
                radius: 40.r,
                backgroundColor: AppConstant.primaryColor,
                backgroundImage: userData['photoURL'].isNotEmpty
                    ? NetworkImage(userData['photoURL'])
                    : null,
                child: userData['photoURL'].isEmpty
                    ? Image.asset(
                        'assets/icons/user.png',
                        color: AppConstant.backgroundColor.withOpacity(0.8),
                        height: 20.sp,
                        fit: BoxFit.fitWidth,
                      )
                    : null,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                userData['displayName'],
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PaymentDetailsScreen(),
                    ),
                  );
                },
                icon: Image.asset(
                  'assets/icons/credit-card.png',
                  height: 25.sp,
                  color: AppConstant.subtitlecolor,
                ),
                title: 'Payment details',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WishlistScreen(
                        user: user,
                      ),
                    ),
                  );
                },
                icon: Image.asset(
                  'assets/icons/heart.png',
                  height: 20.sp,
                  color: AppConstant.subtitlecolor,
                ),
                title: 'Wishlist',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                icon: Image.asset(
                  'assets/icons/shopping-cart.png',
                  height: 20.sp,
                  color: AppConstant.subtitlecolor,
                ),
                title: 'Cart',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OrderHistoryScreen(),
                    ),
                  );
                },
                icon: Image.asset(
                  'assets/icons/tracking.png',
                  height: 25.sp,
                  color: AppConstant.subtitlecolor,
                ),
                title: 'Order history',
              ),
              const Spacer(),
              Card(
                clipBehavior: Clip.hardEdge,
                color: AppConstant.secondaryColor,
                elevation: 0.5,
                child: CustomListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    AuthenticationController.signOut().then(
                      (value) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const AuthenticationScreen(),
                        ),
                      ),
                    );
                  },
                  icon: Image.asset(
                    'assets/icons/logout.png',
                    height: 20.sp,
                    color: AppConstant.subtitlecolor,
                  ),
                  title: 'Log out',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appName,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      ' v$appVersion',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
