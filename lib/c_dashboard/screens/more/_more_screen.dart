import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/custom_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        leading: const BackScreenButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 8.h,
            ),
            // Text(
            //   'General',
            //   style: Theme.of(context).textTheme.headline5,
            // ),
            CustomListTile(
              onTap: () {},
              title: 'My Profile',
              imagePath: 'assets/icons/user-edit.png',
            ),
            CustomListTile(
              onTap: () {},
              title: 'EC Zone',
              imagePath: 'assets/icons/user.png',
            ),
            CustomListTile(
              onTap: () {},
              title: 'Order History',
              imagePath: 'assets/icons/bill.png',
            ),
            CustomListTile(
              onTap: () {},
              title: 'About App',
              imagePath: 'assets/icons/info.png',
            ),
            CustomListTile(
              onTap: () {},
              title: 'Check for update',
              imagePath: 'assets/icons/update.png',
            ),
            CustomListTile(
              onTap: () {},
              title: 'Authentication',
              imagePath: 'assets/icons/fingerprint.png',
            ),
            CustomListTile(
              onTap: () {},
              title: 'Logout',
              imagePath: 'assets/icons/logout.png',
            ),
          ],
        ),
      ),
    );
  }
}
