import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/b_wishlist/wishlist_loading_screen.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/custom_button.dart';
import 'package:ekart/widgets/custom_text_form_field.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:ekart/widgets/shimmer_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentDetailsScreen extends HookWidget {
  const PaymentDetailsScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    final fireAuth = FirebaseAuth.instance.currentUser;
    final userName = useTextEditingController();
    final userEmail = useTextEditingController();
    final userIsEmailVerified = useState<bool?>(false);
    final userIsPhoneVerified = useState<bool?>(false);
    final userPhoto = useState<String?>('');
    final userPhoneNo = useTextEditingController();
    final userAddress = useTextEditingController();
    final detailsKey = GlobalKey<FormState>();
    final isLoading = useState<bool>(false);

    return StreamBuilder<Object>(
      stream: fireRef.collection("user").doc(email).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoadingScreen(
            title: 'Personal Details',
          );
        } else if (snapshot.hasData) {
          Future.delayed(Duration.zero, () {
            dynamic data = snapshot.data;
            userName.text = data['displayName'];
            userEmail.text = data['email'];
            userPhoneNo.text = data['phoneNo'];
            userAddress.text = data['address'];
            userPhoto.value = data['photoURL'];
            userIsEmailVerified.value = data['isEmailVerified'];
            userIsPhoneVerified.value = data['isPhoneNoVerified'];
          });
          if (fireAuth!.emailVerified) {
            updateMailVerifiy(
              fireRef,
              fireAuth,
              email,
            );
          }
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    userPhoto.value!,
                                    fit: BoxFit.fitWidth,
                                    height: 100.sp,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return ShimmerContainer(
                                        width: 100.sp,
                                        height: 100.sp,
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
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
                                      );
                                    },
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
                                          offset: Offset(0.0, 1.0), //(x,y)
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
                            suffixIcon: userIsEmailVerified.value == true
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
                                    onPressed: () {
                                      fireAuth
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
                                          );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppConstant.primaryColor,
                                    ),
                                    child: Text(
                                      'Verify now',
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
                          CustomTextFormField(
                            controller: userPhoneNo,
                            labelText: 'Mobile number',
                            textInputType:
                                const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(','),
                              FilteringTextInputFormatter.deny('-'),
                              FilteringTextInputFormatter.deny(' '),
                              FilteringTextInputFormatter.deny('.'),
                            ],
                            suffixIcon: userIsPhoneVerified.value == true
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
                                : null,
                            validator: (value) {
                              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              RegExp regExp = RegExp(pattern);
                              if (value!.isEmpty) {
                                return 'Please enter mobile number';
                              } else if (!regExp.hasMatch(value)) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
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
                        isLaoding: isLoading.value,
                        onPressed: () {
                          if (detailsKey.currentState!.validate()) {
                            isLoading.value = true;
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
        } else {
          return const ErrorScreen();
        }
      },
    );
  }
}

void updateMailVerifiy(
  FirebaseFirestore fireRef,
  User fireAuth,
  String email,
) {
  fireRef.collection('users').doc(email).update({
    'isEmailVerified': fireAuth.emailVerified,
  });
}
