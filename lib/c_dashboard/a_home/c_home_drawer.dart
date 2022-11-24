import 'package:ekart/b_authentication/authentication_controller.dart';
import 'package:ekart/b_authentication/authentication_screen.dart';
import 'package:ekart/c_dashboard/b_wishlist/wishlist_screen.dart';
import 'package:ekart/c_dashboard/e_profile/_profile_body.dart';
import 'package:ekart/c_dashboard/c_cart/cart_body.dart';
import 'package:ekart/c_dashboard/d_order_history/order_history_body.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.appName,
    required this.appVersion,
    required this.userData,
    required this.email,
    required this.dailyOffValue,
  }) : super(key: key);

  final String appName;
  final String appVersion;
  final dynamic userData;
  final String email;
  final int dailyOffValue;

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
                        height: 30.sp,
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
                      builder: (context) => ProfileBody(
                        email: email,
                      ),
                    ),
                  );
                },
                imagePath: 'assets/icons/profile.png',
                title: 'Personal details',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WishlistScreen(
                        email: email,
                        dailyOffValue: dailyOffValue,
                      ),
                    ),
                  );
                },
                imagePath: 'assets/icons/wishlist.png',
                title: 'Wishlist',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartBody(
                        email: email,
                      ),
                    ),
                  );
                },
                imagePath: 'assets/icons/cart.png',
                title: 'Cart',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OrderHistoryBody(),
                    ),
                  );
                },
                imagePath: 'assets/icons/order-history.png',
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
                  imagePath: 'assets/icons/logout.png',
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
