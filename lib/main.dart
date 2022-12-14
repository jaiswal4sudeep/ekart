import 'package:ekart/my_app.dart';
import 'package:ekart/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp()
      .then(
        (value) => initNotificationService(),
      )
      .then(
        (value) => SystemChrome.setPreferredOrientations(
          [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
        ).then(
          (value) => runApp(
            Phoenix(
              child: const ProviderScope(
                child: MyApp(),
              ),
            ),
          ),
        ),
      );
}
