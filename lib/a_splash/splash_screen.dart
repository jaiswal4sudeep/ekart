import 'package:ekart/b_authentication/authentication_screen.dart';
import 'package:ekart/c_dashboard/_dashboard_screen.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({
    super.key,
  });

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  Future<void> checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        user != null
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>  DashboardScreen(
                    user: user,
                  ),
                ),
              )
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AuthenticationScreen(),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 1.sh,
          width: 1.sw,
          decoration: const BoxDecoration(
            color: AppConstant.backgroundColor,
          ),
        ),
        Center(
          child: CircleAvatar(
            radius: 60.r,
            backgroundColor: AppConstant.secondaryColor,
            child: Image.asset(
              'assets/icons/appLogo.png',
              height: 60.sp,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }
}
