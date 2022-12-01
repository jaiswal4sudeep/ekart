import 'package:ekart/b_authentication/authentication_controller.dart';
import 'package:ekart/b_authentication/authentication_screen.dart';
import 'package:ekart/c_dashboard/screens/more/a_edit_profile/_edit_profile_screen.dart';
import 'package:ekart/c_dashboard/screens/more/b_ec_zone/_ec_zone_screen.dart';
import 'package:ekart/c_dashboard/screens/more/c_order_history/order_history_screen.dart';
import 'package:ekart/c_dashboard/screens/more/d_about_app/_about_app_screen.dart';
import 'package:ekart/c_dashboard/screens/more/services/check_app_latest_version.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_widgets.dart';
import 'package:ekart/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MoreScreenData extends HookWidget {
  const MoreScreenData({
    Key? key,
    required this.email,
    required this.userData,
  }) : super(key: key);

  final String email;
  final dynamic userData;

  @override
  Widget build(BuildContext context) {
    final isAuthActive = useState<bool>(false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [
                  AppConstant.gradientStart,
                  AppConstant.gradientEnd,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: AppConstant.secondaryColor,
                        child: Image.asset(
                          'assets/icons/user_trans.png',
                          color: AppConstant.subtitlecolor,
                          height: 25.r,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                userData['displayName'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppConstant.secondaryColor,
                                    ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              userData['isEmailVerified'] &&
                                      userData['isPhoneNoVerified']
                                  ? Image.asset(
                                      'assets/icons/verify.png',
                                      width: 15.sp,
                                      height: 15.sp,
                                      color: AppConstant.green,
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        Fluttertoast.showToast(
                                          msg:
                                              'Your email or phone no. has not been verified yet!',
                                        );
                                      },
                                      child: Image.asset(
                                        'assets/icons/error.png',
                                        width: 15.sp,
                                        height: 15.sp,
                                        color: AppConstant.red,
                                      ),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            userData['email'],
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: AppConstant.secondaryColor,
                                    ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/ec.png',
                                height: 15.sp,
                                color: AppConstant.secondaryColor,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                userData['ec'].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppConstant.secondaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    email: email,
                  ),
                ),
              );
            },
            title: const TextStyle5(
              content: 'Edit Profile',
            ),
            leading: const ImgStyle(
              img: 'user-edit',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ECZoneScreen(),
                ),
              );
            },
            title: const TextStyle5(
              content: 'EC Zone',
            ),
            leading: const ImgStyle(
              img: 'ec_coin',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderHistoryScreen(),
                ),
              );
            },
            title: const TextStyle5(
              content: 'Order History',
            ),
            leading: const ImgStyle(
              img: 'bill',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutAppScreen(),
                ),
              );
            },
            title: const TextStyle5(
              content: 'About App',
            ),
            leading: const ImgStyle(
              img: 'info',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
            ),
          ),
          ListTile(
            onTap: () async {
              await checkAppLatestVersion()
                  ? Fluttertoast.showToast(msg: 'New version found')
                  : Fluttertoast.showToast(msg: 'Already the latest version');
            },
            title: const TextStyle5(
              content: 'Check for update',
            ),
            leading: const ImgStyle(
              img: 'update',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
            ),
          ),
          ListTile(
            onTap: () {
              isAuthActive.value = !isAuthActive.value;
            },
            title: const TextStyle5(
              content: 'Authentication',
            ),
            leading: const ImgStyle(
              img: 'fingerprint',
            ),
            trailing: Switch(
              value: isAuthActive.value,
              onChanged: (val) {
                isAuthActive.value = val;
              },
              activeColor: AppConstant.primaryColor,
            ),
          ),
          ListTile(
            onTap: () {
              AuthenticationController.signOut().then(
                (value) => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AuthenticationScreen(),
                  ),
                ),
              );
            },
            title: const TextStyle5(
              content: 'Logout',
            ),
            leading: const ImgStyle(
              img: 'logout',
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
