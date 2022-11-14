import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/favorites/favorites_loading_screen.dart';
import 'package:ekart/c_dashboard/screens/favorites/favorites_scaffold.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FavoritesScreen extends HookWidget {
  const FavoritesScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    return StreamBuilder<Object>(
      stream: fireRef.collection('users').doc(user.email).snapshots(),
      builder: (context, favItemSnapshot) {
        if (favItemSnapshot.connectionState == ConnectionState.waiting) {
          return const FavoritesLoadingScreen();
        } else if (favItemSnapshot.hasData) {
          return FavoritesScaffold(
            favItemData: favItemSnapshot.data,
            user: user,
          );
        } else {
          return const ErrorScreen();
        }
      },
    );
  }
}
