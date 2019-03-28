import 'package:firebase_notification/services/firebase/firebase.dart';
import 'package:firebase_notification/services/shared_preferences.dart';
import 'package:firebase_notification/util/dropdown.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  void initState() {
    super.initState();
    firebase.populateUserforNotification();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = '';
  String body = '';
  String selectedChoice;
  String member;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin Panel'),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(labelText: 'Title'),
                    onSaved: (value) {
                      title = value;
                    },
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    maxLines: 8,
                    decoration: InputDecoration(
                        hintText: 'Notification Body',
                        border: OutlineInputBorder()),
                    onSaved: (value) {
                      body = value;
                    },
                  ),
                ),
                ListTile(
                  title: DropdownButtonFormField(
                    hint: Text('Send to'),
                    value: selectedChoice,
                    items: [
                      DropdownMenuItem(
                          child: Text('Send to All'), value: 'all'),
                      DropdownMenuItem(child: Text('Send to one'), value: 'one')
                    ],
                    onSaved: (value) {
                      selectedChoice = value;
                    },
                    onChanged: (value) {
                      selectedChoice = value;

                      setState(() {});
                    },
                  ),
                ),
                (selectedChoice == 'one')
                    ? ListTile(
                        title: DropdownButtonFormField(
                          hint: Text('Member'),
                          value: member,
                          items: userIds,
                          onSaved: (value) {
                            member = value;
                          },
                          onChanged: (value) {
                            member = value;

                            setState(() {});
                          },
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () async {
                      _formKey.currentState.save();
                      print(body);
                      print(title);
                      print(selectedChoice);
                      print(member);
                      await firebase.addNotification(
                          title, body, selectedChoice, member);
                      print('Notification sent');
                    },
                    child: Container(
                      color: Colors.blueGrey,
                      child: ListTile(
                        title: Center(child: Text('Submit')),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: GestureDetector(
              child: Container(
                color: Colors.redAccent,
                child: ListTile(
                  title: Text('Logout'),
                ),
              ),
              onTap: () async {
                await local.clear();
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            ),
          )
        ],
      ),
    );
  }
}
