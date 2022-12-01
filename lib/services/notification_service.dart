import 'package:ekart/utils/app_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> initNotificationService() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
    messaging.subscribeToTopic('new_update');
    fcmToken = (await messaging.getToken())!;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
