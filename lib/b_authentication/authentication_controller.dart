import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController {
  static Future<User?> signInWithGoogle() async {
    FirebaseFirestore fireRef = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
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
              'photoURL': user.photoURL.toString(),
              'wishlist': [],
            },
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
}
