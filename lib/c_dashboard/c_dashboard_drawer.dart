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
  }) : super(key: key);

  final String appName;
  final String appVersion;
  final dynamic userData;

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
                },
                icon: Icons.payments_rounded,
                title: 'Payment details',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.favorite_rounded,
                title: 'My favorites',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.shopping_bag_rounded,
                title: 'My cart',
              ),
              CustomListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.file_copy_rounded,
                title: 'Transaction history',
              ),
              const Spacer(),
              Card(
                clipBehavior: Clip.hardEdge,
                color: AppConstant.secondaryColor,
                elevation: 0.5,
                child: CustomListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icons.logout_rounded,
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
