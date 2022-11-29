import 'package:ekart/c_dashboard/dashboard_root.dart';
import 'package:ekart/widgets/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ekart/b_authentication/authentication_controller.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_button.dart';

class AuthenticationScreen extends HookWidget {
  const AuthenticationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isGoogleLoading = useState<bool>(false);
    final isEmailLoading = useState<bool>(false);
    final navigator = Navigator.of(context);
    final userName = useTextEditingController();
    final userEmail = useTextEditingController();
    final password = useTextEditingController();
    final confirmPassword = useTextEditingController();
    final isPassHidden = useState<bool>(true);
    final authKey = GlobalKey<FormState>();
    final doesUserExist = useState<bool>(false);
    final isEmailPage = useState<bool>(true);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: authKey,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: !isEmailPage.value
                      ? SizedBox(
                          width: 30.sp,
                          height: 30.sp,
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                isEmailPage.value = true;
                                userName.clear();
                                password.clear();
                                confirmPassword.clear();
                                isPassHidden.value = true;
                                doesUserExist.value = false;
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_left_rounded,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 30.sp,
                          height: 30.sp,
                        ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    radius: 25.r,
                    backgroundColor: AppConstant.primaryColor.withOpacity(0.1),
                    child: Image.asset(
                      'assets/icons/appLogo.png',
                      width: 35.r,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                if (isEmailPage.value)
                  Center(
                    child: CustomTextFormField(
                      controller: userEmail,
                      labelText: 'E-Mail',
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                if (!doesUserExist.value && !isEmailPage.value)
                  Center(
                    child: CustomTextFormField(
                      controller: userName,
                      labelText: 'Full name',
                      textInputType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.trim().length < 4) {
                          return 'Name must be at least 4 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                if (!isEmailPage.value)
                  Center(
                    child: CustomTextFormField(
                      controller: password,
                      labelText: 'Password',
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      isPassword: isPassHidden.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          isPassHidden.value = !isPassHidden.value;
                        },
                        icon: isPassHidden.value
                            ? const Icon(Icons.visibility_rounded)
                            : const Icon(
                                Icons.visibility_off_rounded,
                              ),
                        color: AppConstant.subtitlecolor,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the password';
                        }
                        if (value.trim().length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                if (doesUserExist.value && !isEmailPage.value)
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      onPressed: () {},
                      title: 'Forgot password ?',
                    ),
                  ),
                if (!doesUserExist.value && !isEmailPage.value)
                  Center(
                    child: CustomTextFormField(
                      controller: confirmPassword,
                      labelText: 'Confirm Password',
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      isPassword: isPassHidden.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          isPassHidden.value = !isPassHidden.value;
                        },
                        icon: isPassHidden.value
                            ? const Icon(Icons.visibility_rounded)
                            : const Icon(
                                Icons.visibility_off_rounded,
                              ),
                        color: AppConstant.subtitlecolor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the password';
                        }
                        if (value != password.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                    ),
                  ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: SizedBox(
                    width: 0.85.sw,
                    height: 40.h,
                    child: GradientButton(
                      isLaoding: isEmailLoading.value,
                      onTap: () async {
                        if (authKey.currentState!.validate()) {
                          if (isEmailPage.value) {
                            isEmailLoading.value = true;
                            doesUserExist.value = await AuthenticationController
                                .checkDoesUserExist(
                              userEmail.text,
                            );
                            isEmailPage.value = false;
                            isEmailLoading.value = false;
                          } else if (!isEmailPage.value) {
                            isEmailLoading.value = true;
                            User? user;
                            if (doesUserExist.value) {
                              user =
                                  await AuthenticationController.loginWithEmail(
                                userEmail.text.trim(),
                                password.text.trim(),
                              );
                            } else {
                              user = await AuthenticationController
                                  .createAccountWithEmail(
                                userName.text.trim(),
                                userEmail.text.trim(),
                                password.text.trim(),
                              );
                            }
                            isEmailLoading.value = false;
                            if (user != null) {
                              navigator.pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => DashboardRoot(
                                    email: userEmail.text,
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      title: isEmailPage.value
                          ? 'Continue'
                          : doesUserExist.value
                              ? 'Log in'
                              : 'Sign up',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const OrDivider(),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: SizedBox(
                    width: 0.85.sw,
                    height: 40.h,
                    child: Material(
                      color: AppConstant.transparent,
                      clipBehavior: Clip.hardEdge,
                      child: GoogleButton(
                        onTap: () async {
                          isGoogleLoading.value = true;
                          User? user =
                              await AuthenticationController.signInWithGoogle();
                          isGoogleLoading.value = false;
                          if (user != null) {
                            navigator.pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => DashboardRoot(
                                  email: user.email!,
                                ),
                              ),
                            );
                          }
                        },
                        title: 'Continue with Google',
                        hvIcon: true,
                        isLaoding: isGoogleLoading.value,
                        icon: Image.asset(
                          'assets/icons/google.png',
                          height: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
