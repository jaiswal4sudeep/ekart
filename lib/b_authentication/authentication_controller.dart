import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireRef = FirebaseFirestore.instance;

class AuthenticationController {
  static Future<User?> signInWithGoogle() async {
    User? user;
    bool? isNewUser;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        var getData = await fireRef.collection('user').doc(user!.email).get();
        isNewUser = getData.exists ? false : true;

        if (isNewUser) {
          await fireRef.collection("user").doc(userCredential.user!.email).set(
            {
              'displayName': user.displayName.toString(),
              'email': user.email.toString(),
              'phoneNo': '',
              'homeAddress': [],
              'workAddress': [],
              'wishlist': [],
              'isPhoneNoVerified': false,
              'isEmailVerified': user.emailVerified,
            },
          ).onError(
            (error, stackTrace) => Fluttertoast.showToast(
              msg: 'An error occured',
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Fluttertoast.showToast(
            msg: 'The account already exists with a different credential',
          );
        } else if (e.code == 'invalid-credential') {
          Fluttertoast.showToast(
            msg: 'Error occurred while accessing credentials. Try again.',
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Something went wrong!',
        );
        throw UnimplementedError();
      }
    }

    return user;
  }

  static Future<User?> createAccountWithEmail(
    String userName,
    String email,
    String password,
  ) async {
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      user = auth.currentUser;
      bool? isNewUser = userCredential.additionalUserInfo?.isNewUser;
      if (isNewUser!) {
        await fireRef.collection("user").doc(userCredential.user!.email).set(
          {
            'displayName': userName,
            'email': email,
            'phoneNo': '',
            'homeAddress': [],
            'workAddress': [],
            'wishlist': [],
            'isPhoneNoVerified': false,
            'isEmailVerified': user!.emailVerified,
          },
        ).onError(
          (error, stackTrace) => Fluttertoast.showToast(
            msg: 'An error occured',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: 'The password provided is too weak',
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'The account already exists for that email',
        );
      } else {
        Fluttertoast.showToast(
          msg: e.code.toString(),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
    return user;
  }

  static Future<User?> loginWithEmail(
    String email,
    String password,
  ) async {
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'No user found for that email',
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Wrong password provided',
        );
      } else {
        Fluttertoast.showToast(
          msg: e.code.toString(),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
    return user;
  }

  static Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong!',
      );
    }
  }

  static Future<bool> checkDoesUserExist(
    String email,
  ) async {
    bool doesExist = await fireRef
        .collection('user')
        .where('email', isEqualTo: email)
        .get()
        .then(
          (value) => value.size > 0 ? true : false,
        );
    return doesExist;
  }
}
