import 'package:firebase_notification/services/firebase/firebase_login.dart';
import 'package:firebase_notification/services/firebase/firestore.dart';

class FirebaseFunctions with FirebaseLogin, CloudFireStore {}

FirebaseFunctions firebase = FirebaseFunctions();
