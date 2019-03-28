import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notification/models/user.dart';
import 'package:firebase_notification/util/dropdown.dart';
import 'package:flutter/material.dart';

class CloudFireStore {
  Future addUser(String userId, String email, String name) async {
    await Firestore.instance.collection('users').document(userId).setData({
      'userId': userId,
      'email': email,
      'name': name,
    });
  }

  Future setfcmToken(String fcmToken) async {
    print('Set FCM TOKen to FireBase');
    await Firestore.instance
        .collection('users')
        .document(userObject.userId)
        .setData({'fcmToken': fcmToken}, merge: true);
    await Firestore.instance
        .collection('fcmtokens')
        .document(userObject.userId)
        .setData({'fcmToken': fcmToken}, merge: true);
  }

  Future addNotification(
      String title, String body, String selectedChoice, String member) async {
    await Firestore.instance.collection('notifications').document().setData({
      'title': title,
      'body': body,
      'choice': (selectedChoice == 'all') ? selectedChoice : member
    }, merge: true);
  }

  Future populateUserforNotification() async {
    await Firestore.instance
        .collection('users')
        .getDocuments()
        .then((snapshots) {
      userIds.clear();
      for (var item in snapshots.documents) {
        userIds.add(DropdownMenuItem(
            child: Text(item.data['email']), value: item.data['fcmToken']));
      }
    });
  }
}
