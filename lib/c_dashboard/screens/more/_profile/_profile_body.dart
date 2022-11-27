import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/more/_profile/a_profile_data.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    final fireAuth = FirebaseAuth.instance;

    return StreamBuilder<Object>(
      stream: fireRef.collection('user').doc(email).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.dotsTriangle(
            color: AppConstant.titlecolor,
            size: 40.sp,
          );
        } else if (snapshot.hasData) {
          return ProfileData(
            personalData: snapshot.data,
            fireRef: fireRef,
            fireAuth: fireAuth,
          );
        } else {
          return const Text('An error occured');
        }
      },
    );
  }
}
