import 'package:ekart/b_authentication/authentication_controller.dart';
import 'package:ekart/b_authentication/authentication_screen.dart';
import 'package:ekart/c_dashboard/screens/b_wishlist/wishlist_screen.dart';
import 'package:ekart/c_dashboard/screens/cart/cart_screen.dart';
import 'package:ekart/c_dashboard/screens/order_history_screen.dart';
import 'package:ekart/c_dashboard/screens/a_personal_details/personal_details_screen.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
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
                      builder: (context) => PaymentDetailsScreen(
                        email: email,
                        userNameS: userData['displayName'],
                        userPhoneNoS: userData['phoneNo'],
                        userAddressS: userData['address'],
                        userPhotoS: userData['photoURL'],
                        userIsEmailVerifiedS: userData['isEmailVerified'],
                        userIsPhoneVerifiedS: userData['isPhoneNoVerified'],
                      ),
                    ),
                  );
                },
                imagePath: 'assets/icons/user-avatar.png',
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
                imagePath: 'assets/icons/heart.png',
                title: 'Wishlist',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        email: email,
                      ),
                    ),
                  );
                },
                imagePath: 'assets/icons/shopping-cart.png',
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
                imagePath: 'assets/icons/tracking.png',
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
