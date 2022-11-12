import 'package:ekart/c_dashboard/b_dashboard_body.dart';
import 'package:ekart/c_dashboard/c_dashboard_drawer.dart';
import 'package:ekart/c_dashboard/screens/cart_screen.dart';
import 'package:ekart/c_dashboard/screens/favorites/favorites_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({
    Key? key,
    required this.productData,
    required this.appName,
    required this.appVersion,
    required this.userData,
    required this.user,
  }) : super(key: key);
  final dynamic productData;
  final dynamic userData;
  final String appName;
  final String appVersion;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EKart',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    user: user,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      drawer: DashboardDrawer(
        userData: userData,
        appName: appName,
        appVersion: appVersion,
      ),
      body: DashboardBody(
        productData: productData,
      ),
    );
  }
}
