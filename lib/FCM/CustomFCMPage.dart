import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// https://firebase.google.com/docs/cloud-messaging/flutter/receive


class CustomFCM extends StatefulWidget {
  const CustomFCM({Key? key}) : super(key: key);

  @override
  _CustomFCMState createState() => _CustomFCMState();
}

class _CustomFCMState extends State<CustomFCM> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((value) {
      print(value);
      //dCvHtbW_tUxHgl2i0F3g5U:APA91bEw_fab53MPo68xtQzzMMWLmAB9xK3ssLfvkl8dHeRaRSr5gHfIw54kCcM5Ddll3NRN0lk6d-B_0c0hOfCohjrXq8fz6SnhX1t_Hv1XoL_kaa9ARyHmrW6wkz_UZXT1lI8vtP98

    });
    _checkAuth();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    _initGoogleMobileAds();

  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _checkAuth() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

  }
  Future<InitializationStatue> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }
}
