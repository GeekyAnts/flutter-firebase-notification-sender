import 'package:firebase_notification/models/user.dart';
import 'package:firebase_notification/services/firebase/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFile {
  //SET FUNCTIONS
  Future setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_id", userId);
    userObject.userId = userId;
  }

  Future setemail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    userObject.email = email;
  }

  Future setname(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
    userObject.name = name;
  }

  //RETURN FUNCTIONS
  Future<String> returnUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("user_id");
    return userId;
  }

  Future<String> returnName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name");
    return name;
  }

  Future<String> returnemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    return email;
  }

  //LOGOUT
  Future<Null> clear() async {
    print('Logout');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    firebase.logOUt();
  }

  sharedToLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userObject.email = prefs.getString('email');
    userObject.name = prefs.getString('name');
    userObject.userId = prefs.getString('user_id');
    print('saved to local');
  }
}

LocalFile local = LocalFile();
