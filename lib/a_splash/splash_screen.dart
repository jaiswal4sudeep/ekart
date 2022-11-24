import 'package:ekart/b_authentication/authentication_screen.dart';
import 'package:ekart/c_dashboard/dashboard_root.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> checkUserStatus() async {
      User? user = FirebaseAuth.instance.currentUser;
      Future.delayed(
        const Duration(seconds: 1),
        () {
          user != null
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DashboardRoot(
                      email: user.email!,
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

    useEffect(() {
      checkUserStatus();
      return null;
    });
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
          child: Image.asset(
            'assets/icons/appLogo.png',
            height: 100.r,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
