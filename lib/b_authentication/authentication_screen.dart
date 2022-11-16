import 'package:ekart/c_dashboard/home/_dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ekart/b_authentication/authentication_controller.dart';
import 'package:ekart/b_authentication/header_painter.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_button.dart';

class AuthenticationScreen extends HookWidget {
  const AuthenticationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);
    final navigator = Navigator.of(context);
    return Stack(
      children: [
        Container(
          width: 1.sw,
          height: 1.sh,
          color: AppConstant.backgroundColor,
        ),
        Container(
          width: 1.sw,
          height: 10.h,
          color: AppConstant.gradientStart,
        ),
        CustomPaint(
          size: Size(1.sw, (1.sw * 0.7795823665893271).toDouble()),
          painter: HeaderPainter(),
        ),
        Positioned(
          top: 125,
          left: 25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 28.sp,
                      color: AppConstant.backgroundColor,
                    ),
              ),
              Text(
                'EKart',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                      color: AppConstant.backgroundColor,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Column(
            children: [
              SizedBox(
                height: 0.5.sh - 60.h,
              ),
              Image.asset(
                'assets/icons/appLogo.png',
                height: 80.h,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 0.85.sw,
                child: Text(
                  'Order Online in Fingertips',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppConstant.titlecolor.withOpacity(0.8),
                      ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 0.85.sw,
                height: 40.h,
                child: Material(
                  color: AppConstant.transparent,
                  clipBehavior: Clip.hardEdge,
                  child: GradientButton(
                    onTap: () async {
                      isLoading.value = true;
                      User? user =
                          await AuthenticationController.signInWithGoogle();
                      isLoading.value = false;
                      if (user != null) {
                        navigator.pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(
                              user: user,
                            ),
                          ),
                        );
                      }
                    },
                    title: 'Continue with Google',
                    hvIcon: true,
                    isLaoding: isLoading.value,
                    icon: Image.asset(
                      'assets/icons/google.png',
                      height: 22.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
