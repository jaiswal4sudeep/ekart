import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/a_personal_details/a_personal_details_scaffold.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:ekart/widgets/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({
    super.key,
    required this.email,
  });
  final String email;

  // late Timer emailCountDownTimer;
  // late Timer phoneCountDownTimer;
  // late Timer emailCheckTimer;
  // late TextEditingController userName;
  // late TextEditingController userEmail;
  // late TextEditingController userPhoneNo;
  // late String userPhoto;
  // bool isLoading = false;
  // bool isEmailTimerStarted = false;
  // bool isPhoneTimerStarted = false;
  // bool userIsPhoneVerified = false;
  // bool userIsEmailVerified = false;
  // int countDownSecEmail = 59;
  // int countDownSecPhone = 59;
  // final detailsKey = GlobalKey<FormState>();
  // final validatePhoneNo = GlobalKey<FormState>();
  // final FirebaseAuth fireAuth = FirebaseAuth.instance;

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

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    final fireAuth = FirebaseAuth.instance;
    return FutureBuilder<Object>(
      future: fireRef.collection('user').doc(email).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasData) {
          return PersonalDetailsScaffold(
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
