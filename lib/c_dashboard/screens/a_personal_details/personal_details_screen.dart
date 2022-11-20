import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/custom_button.dart';
import 'package:ekart/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({
    super.key,
    required this.email,
    required this.userNameS,
    this.userPhoneNoS,
    this.userPhotoS,
    this.userAddressS,
    this.userIsEmailVerifiedS,
    this.userIsPhoneVerifiedS,
  });
  final String email;
  final String userNameS;
  final String? userPhoneNoS;
  final String? userPhotoS;
  final String? userAddressS;
  final bool? userIsEmailVerifiedS;
  final bool? userIsPhoneVerifiedS;

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  late Timer emailCountDownTimer;
  late Timer phoneCountDownTimer;
  late Timer emailCheckTimer;
  late TextEditingController userName;
  late TextEditingController userEmail;
  late TextEditingController userPhoneNo;
  late TextEditingController userAddress;
  late String userPhoto;
  bool isLoading = false;
  bool isEmailTimerStarted = false;
  bool isPhoneTimerStarted = false;
  bool userIsPhoneVerified = false;
  bool userIsEmailVerified = false;
  int countDownSecEmail = 5;
  int countDownSecPhone = 5;
  final detailsKey = GlobalKey<FormState>();
  final validatePhoneNo = GlobalKey<FormState>();
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireRef = FirebaseFirestore.instance;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  fetchStoredData() {
    userName = TextEditingController(
      text: widget.userNameS,
    );
    userEmail = TextEditingController(
      text: widget.email,
    );
    userPhoneNo = TextEditingController(
      text: widget.userPhoneNoS,
    );
    userAddress = TextEditingController(
      text: widget.userAddressS,
    );
    userPhoto = widget.userPhotoS!;
    userIsEmailVerified = widget.userIsEmailVerifiedS!;
    userIsPhoneVerified = widget.userIsPhoneVerifiedS!;
    setState(() {});
  }

  startCountDownEmail() {
    setState(() {
      isEmailTimerStarted = true;
    });
    const oneSec = Duration(seconds: 1);
    emailCountDownTimer = Timer.periodic(
      oneSec,
      (_) {
        if (countDownSecEmail == 0) {
          setState(() {
            emailCountDownTimer.cancel();
            countDownSecEmail = 5;
            isEmailTimerStarted = false;
          });
        } else {
          setState(() {
            countDownSecEmail--;
          });
        }
      },
    );
  }

  startCountDownPhone() {
    setState(() {
      isPhoneTimerStarted = true;
    });
    const oneSec = Duration(seconds: 1);
    phoneCountDownTimer = Timer.periodic(
      oneSec,
      (_) {
        if (countDownSecPhone == 0) {
          setState(() {
            phoneCountDownTimer.cancel();
            isPhoneTimerStarted = false;
          });
        } else {
          setState(() {
            countDownSecPhone--;
          });
        }
      },
    );
  }

  updateUserDetails() {
    setState(() {
      isLoading = true;
    });
  }

  checkEmailVerified() {
    fireAuth.currentUser!.reload();
    setState(() {
      userIsEmailVerified = fireAuth.currentUser!.emailVerified;
    });
    if (userIsEmailVerified) {
      emailCheckTimer.cancel();
      fireRef.collection('user').doc(userEmail.text).update({
        'isEmailVerified': userIsEmailVerified,
      });
    }
  }

  @override
  void initState() {
    fetchStoredData();
    super.initState();
    if (!userIsEmailVerified) {
      emailCheckTimer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    userName.dispose();
    userEmail.dispose();
    userPhoneNo.dispose();
    userAddress.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Details',
        ),
        leading: const BackScreenButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: detailsKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          userPhoto.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    userPhoto,
                                    fit: BoxFit.fitWidth,
                                    height: 100.sp,
                                  ),
                                )
                              : Container(
                                  width: 100.sp,
                                  height: 100.sp,
                                  decoration: const BoxDecoration(
                                    color: AppConstant.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/user.png',
                                      color: AppConstant.backgroundColor
                                          .withOpacity(0.8),
                                      height: 30.sp,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 30.sp,
                              height: 30.sp,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppConstant.secondaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 3.0,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.edit_rounded,
                                  color: AppConstant.subtitlecolor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFormField(
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
                    CustomTextFormField(
                      controller: userEmail,
                      labelText: 'Email',
                      textInputType: TextInputType.emailAddress,
                      readOnly: true,
                      suffixIcon: userIsEmailVerified
                          ? Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ImageIcon(
                                const AssetImage(
                                  'assets/icons/verify.png',
                                ),
                                size: 20.sp,
                                color: AppConstant.subtitlecolor,
                              ),
                            )
                          : TextButton(
                              onPressed: isEmailTimerStarted
                                  ? () {
                                      Fluttertoast.showToast(
                                        msg:
                                            'Please wait for 00:${countDownSecEmail.toString().padLeft(2, '0')} seconds',
                                      );
                                    }
                                  : () {
                                      fireAuth.currentUser!
                                          .sendEmailVerification()
                                          .then(
                                            (value) => Fluttertoast.showToast(
                                              msg:
                                                  'Verification code sent. Please check your mailbox',
                                            ),
                                          )
                                          .onError(
                                            (error, stackTrace) =>
                                                Fluttertoast.showToast(
                                              msg: 'An error occured',
                                            ),
                                          )
                                          .then(
                                            (value) => startCountDownEmail(),
                                          );
                                    },
                              style: TextButton.styleFrom(
                                foregroundColor: AppConstant.primaryColor,
                              ),
                              child: Text(
                                isEmailTimerStarted
                                    ? '00:${countDownSecEmail.toString().padLeft(2, '0')}'
                                    : 'Verify now',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: AppConstant.primaryColor,
                                    ),
                              ),
                            ),
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
                    Form(
                      key: validatePhoneNo,
                      child: CustomTextFormField(
                        controller: userPhoneNo,
                        labelText: 'Mobile number',
                        textInputType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(','),
                          FilteringTextInputFormatter.deny('-'),
                          FilteringTextInputFormatter.deny(' '),
                          FilteringTextInputFormatter.deny('.'),
                        ],
                        suffixIcon: userIsPhoneVerified
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ImageIcon(
                                  const AssetImage(
                                    'assets/icons/verify.png',
                                  ),
                                  size: 20.sp,
                                  color: AppConstant.subtitlecolor,
                                ),
                              )
                            : TextButton(
                                onPressed: isPhoneTimerStarted
                                    ? () {
                                        Fluttertoast.showToast(
                                          msg:
                                              'Please wait for 00:${countDownSecEmail.toString().padLeft(2, '0')} seconds',
                                        );
                                      }
                                    : () {
                                        // fireAuth.currentUser!
                                        //     .sen()
                                        //     .then(
                                        //       (value) => Fluttertoast.showToast(
                                        //         msg:
                                        //             'Verification code sent. Please check your inbox',
                                        //       ),
                                        //     )
                                        //     .onError(
                                        //       (error, stackTrace) =>
                                        //           Fluttertoast.showToast(
                                        //         msg: 'An error occured',
                                        //       ),
                                        //     )
                                        //     .then(
                                        //       (value) => startCountDown(),
                                        //     );
                                        if (validatePhoneNo.currentState!
                                            .validate()) {
                                          startCountDownPhone();
                                        }
                                      },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppConstant.primaryColor,
                                ),
                                child: Text(
                                  isPhoneTimerStarted
                                      ? '00:${countDownSecPhone.toString().padLeft(2, '0')}'
                                      : 'Verify now',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: AppConstant.primaryColor,
                                      ),
                                ),
                              ),
                        validator: (value) {
                          RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                          if (value!.isEmpty) {
                            return 'Please enter mobile number';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                    CustomTextFormField(
                      controller: userAddress,
                      labelText: 'Address',
                      textInputType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your address';
                        }
                        if (value.trim().length < 4) {
                          return 'Address must be at least 4 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 0.85.sw,
                height: 40.sp,
                child: CustomOutlinedButton(
                  isLaoding: isLoading,
                  onPressed: () {
                    if (detailsKey.currentState!.validate() &&
                        validatePhoneNo.currentState!.validate()) {
                      updateUserDetails();
                    }
                  },
                  title: 'Save',
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void updateMailVerifiy(
  FirebaseFirestore fireRef,
  FirebaseAuth fireAuth,
  String email,
) {
  fireRef.collection('users').doc(email).update({
    'isEmailVerified': fireAuth.currentUser!.emailVerified,
  });
}
