import 'package:firebase_notification/models/user.dart';
import 'package:firebase_notification/screens/admin.dart';
import 'package:firebase_notification/screens/login_page.dart';
import 'package:firebase_notification/services/firebase/firebase.dart';
import 'package:firebase_notification/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class Routes {
  final Map<String, WidgetBuilder> routes = {
    '/login': (BuildContext context) => Login(),
    '/admin': (BuildContext context) => Admin(),
  };
  Routes() {
    runApp(MainWidget(routes));
  }
}

class MainWidget extends StatelessWidget {
  final Map<String, WidgetBuilder> routes;
  MainWidget(this.routes);
  @override
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WaitScreen(),
      routes: routes,
    );
  }
}

class WaitScreen extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initMethod(context) async {
//FCM TOKEN
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume $message');
      },
    );
    userObject.fcmToken = await _firebaseMessaging.getToken();
    print('fcm token -> ${userObject.fcmToken}');
//FCM TOKEN
    String user = await local.returnUserId();
    if (user == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      await local.sharedToLocal();
      await firebase.setfcmToken(userObject.fcmToken);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/admin', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));

    return Container();
  }
}
