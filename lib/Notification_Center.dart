import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:resort/main.dart';

import '../../../Authentication/Providers/Authentication.dart';

import '../.././Global/Widgets/Toasts.dart';

Future<void> On_Background_Message(RemoteMessage message) async {
  if (Get_Token != null) {
    // navigator_key.currentState?.pushNamed(Edit_Business_Hours_Screen.routeName);
  }
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // if (Get_Token != null) {
    //   navigator_key.currentState
    //       ?.pushNamed(Edit_Business_Hours_Screen.routeName);
    // }
  }

  Future Init_Push_Notification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(On_Background_Message);

    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      if (notification == null) return;

      Show_Text_Toast(
        onTap: null,
        context: navigator_key.currentState!.context,
        text: 'You\'ve got a new message. Check it out now!',
      );
      HapticFeedback.vibrate();
    });
  }

  Future<void> Request_Permission() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
  }

  Future<String?> Get_FCM_Token() async {
    return _firebaseMessaging.getToken();
  }

  Future<void> Init_Notification() async {
    Init_Push_Notification();
  }
}
