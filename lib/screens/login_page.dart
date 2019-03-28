import 'package:firebase_notification/models/user.dart';
import 'package:firebase_notification/services/firebase/firebase.dart';
import 'package:firebase_notification/services/shared_preferences.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Login With Gmail'),
            onPressed: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.transparent,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  });
              dynamic user = await firebase.handleSignIn();
              if (user.isEmailVerified) {
                await local.setUserId(user.uid);
                await local.setemail(user.email);
                await local.setname(user.displayName);
                await firebase.addUser(user.uid, user.email, user.displayName);
                await firebase.setfcmToken(userObject.fcmToken);

                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/admin', (Route<dynamic> route) => false);
              } else {
                SnackBar(
                  content: Text('Login Failed'),
                  duration: Duration(seconds: 1),
                );
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
