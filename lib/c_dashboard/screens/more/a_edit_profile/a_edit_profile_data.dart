import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/more/a_edit_profile/b_new_address_screen.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_widgets.dart';
import 'package:ekart/widgets/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileData extends HookWidget {
  const EditProfileData({
    super.key,
    required this.personalData,
    required this.fireRef,
    required this.fireAuth,
  });
  final dynamic personalData;
  final FirebaseFirestore fireRef;
  final FirebaseAuth fireAuth;

  @override
  Widget build(BuildContext context) {
    final userEmail = useTextEditingController(
      text: personalData['email'],
    );
    final userPhoneNo = useTextEditingController(
      text: personalData['phoneNo'],
    );
    final isEmailVerified = useState<bool>(fireAuth.currentUser!.emailVerified);
    final isEmailTimerStarted = useState<bool>(false);

    final isPhoneNoVerified = useState<bool>(personalData['isPhoneNoVerified']);
    final isPhoneTimerStarted = useState<bool>(false);

    final countDownSecEmail = useState<int>(59);
    final countDownSecPhone = useState<int>(59);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: const BackScreenButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 5.h,
            ),
            CustomTextFormField(
              controller: userEmail,
              labelText: 'Email',
              textInputType: TextInputType.emailAddress,
              readOnly: true,
              suffixIcon: isEmailVerified.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ImageIcon(
                        const AssetImage(
                          'assets/icons/verify.png',
                        ),
                        size: 20.sp,
                        color: AppConstant.green,
                      ),
                    )
                  : TextButton(
                      onPressed: isEmailTimerStarted.value
                          ? () {
                              Fluttertoast.showToast(
                                msg:
                                    'Please wait for 00:${countDownSecEmail.value.toString().padLeft(2, '0')} seconds',
                              );
                            }
                          : () {
                              // fireAuth.currentUser!
                              //     .sendEmailVerification()
                              //     .then(
                              //       (value) => Fluttertoast.showToast(
                              //         msg:
                              //             'Verification code sent. Please check your mailbox',
                              //       ),
                              //     )
                              //     .onError(
                              //       (error, stackTrace) =>
                              //           Fluttertoast.showToast(
                              //         msg: 'An error occured',
                              //       ),
                              //     )
                              //     .then(
                              //       (value) => startCountDownEmail(),
                              //     );
                            },
                      style: TextButton.styleFrom(
                        foregroundColor: AppConstant.primaryColor,
                      ),
                      child: Text(
                        isEmailTimerStarted.value
                            ? '00:${countDownSecEmail.value.toString().padLeft(2, '0')}'
                            : 'Verify now',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
            CustomTextFormField(
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
              suffixIcon: isPhoneNoVerified.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ImageIcon(
                        const AssetImage(
                          'assets/icons/verify.png',
                        ),
                        size: 20.sp,
                        color: AppConstant.green,
                      ),
                    )
                  : TextButton(
                      onPressed: isPhoneTimerStarted.value
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
                            },
                      style: TextButton.styleFrom(
                        foregroundColor: AppConstant.primaryColor,
                      ),
                      child: Text(
                        isPhoneTimerStarted.value
                            ? '00:${countDownSecPhone.toString().padLeft(2, '0')}'
                            : 'Verify now',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
            Text(
              'Address',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 1.sw,
              height: 38.h,
              child: Material(
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.hardEdge,
                color: AppConstant.backgroundColor,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewAddressScreen(
                          email: personalData['email'],
                        ),
                      ),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppConstant.subtitlecolor.withOpacity(0.4),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '  + Add a new address',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 13.sp,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (personalData['homeAddress'].isNotEmpty ||
                personalData['workAddress'].isNotEmpty)
              SizedBox(
                height: 5.h,
              ),
            if (personalData['homeAddress'].isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.75.sw,
                      child: TextStyle5(
                        content: personalData['homeAddress']['address'] +
                            ', ' +
                            personalData['homeAddress']['city'] +
                            ', ' +
                            personalData['homeAddress']['state'] +
                            ', ' +
                            personalData['homeAddress']['country'] +
                            ' - ' +
                            personalData['homeAddress']['pincode'],
                      ),
                    ),
                    Chip(
                      label: Text(
                        'Home',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              ),
            if (personalData['workAddress'].isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.75.sw,
                      child: TextStyle5(
                        content: personalData['workAddress']['address'] +
                            ', ' +
                            personalData['workAddress']['city'] +
                            ', ' +
                            personalData['workAddress']['state'] +
                            ', ' +
                            personalData['workAddress']['country'] +
                            ' - ' +
                            personalData['workAddress']['pincode'],
                      ),
                    ),
                    Chip(
                      label: Text(
                        'Work',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}



  // late Timer emailCountDownTimer;
  // late Timer phoneCountDownTimer;
  // late Timer emailCheckTimer;

  // startCountDownEmail() {
  //   setState(() {
  //     isEmailTimerStarted = true;
  //   });
  //   const oneSec = Duration(seconds: 1);
  //   emailCountDownTimer = Timer.periodic(
  //     oneSec,
  //     (_) {
  //       if (countDownSecEmail == 0) {
  //         setState(() {
  //           emailCountDownTimer.cancel();
  //           countDownSecEmail = 59;
  //           isEmailTimerStarted = false;
  //         });
  //       } else {
  //         setState(() {
  //           countDownSecEmail--;
  //         });
  //       }
  //     },
  //   );
  // }

  // startCountDownPhone() {
  //   setState(() {
  //     isPhoneTimerStarted = true;
  //   });
  //   const oneSec = Duration(seconds: 1);
  //   phoneCountDownTimer = Timer.periodic(
  //     oneSec,
  //     (_) {
  //       if (countDownSecPhone == 0) {
  //         setState(() {
  //           phoneCountDownTimer.cancel();
  //           countDownSecEmail = 59;
  //           isPhoneTimerStarted = false;
  //         });
  //       } else {
  //         setState(() {
  //           countDownSecPhone--;
  //         });
  //       }
  //     },
  //   );
  // }

  // updateUserDetails() {
  //   setState(() {
  //     isLoading = true;
  //   });
  // }

  // checkEmailVerified() {
  //   fireAuth.currentUser!.reload();
  //   setState(() {
  //     userIsEmailVerified = fireAuth.currentUser!.emailVerified;
  //   });
  //   if (userIsEmailVerified) {
  //     emailCheckTimer.cancel();
  //     fireRef.collection('user').doc(userEmail.text).update({
  //       'isEmailVerified': userIsEmailVerified,
  //     });
  //   }
  // }

  // fetchStoredData() {
  //   userName = TextEditingController(
  //     text: 'widget.userNameS',
  //   );
  //   userEmail = TextEditingController(
  //     text: widget.email,
  //   );
  //   userPhoneNo = TextEditingController(
  //     text: 'widget.userPhoneNoS',
  //   );
  //   userPhoto = '';
  //   userIsEmailVerified = fireAuth.currentUser!.emailVerified;
  //   userIsPhoneVerified = false;
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   fetchStoredData();
  //   super.initState();
  //   if (!userIsEmailVerified) {
  //     emailCheckTimer = Timer.periodic(const Duration(seconds: 3), (_) {
  //       checkEmailVerified();
  //     });
  //   }
  // }
