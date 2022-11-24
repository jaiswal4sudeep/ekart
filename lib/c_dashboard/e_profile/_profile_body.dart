import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/e_profile/a_profile_data.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:ekart/widgets/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          return const LoadingScreen();
        } else if (snapshot.hasData) {
          return ProfileData(
            personalData: snapshot.data,
            fireRef: fireRef,
            fireAuth: fireAuth,
          );
        } else {
          return const ErrorScreen();
        }
      },
    );
  }
}
