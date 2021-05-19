import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:workout_tracker2/ui/ui_navbar.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage();
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool toggleDark = false;
  bool toggleAlarm = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = 4;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.background,
        appBar: AppBar(
          // backgroundColor: theme.appBar,
          elevation: 5,
          title: Text("Settings"),
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 10,
            margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
            child: Container(
                padding: const EdgeInsets.all(15.0),
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Dark Mode",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Switch(
                            value: toggleDark,
                            onChanged: (value) {
                              setState(() {
                                toggleDark = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Workout Alarm",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Switch(
                            // inactiveThumbColor: Colors.white,
                            // activeTrackColor: Colors.green[10],
                            // activeColor: Colors.green,
                            value: toggleAlarm,
                            onChanged: (value) {
                              setState(() {
                                toggleAlarm = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 80),
                      SizedBox(
                        width: double.maxFinite,
                        child: MaterialButton(
                          color: Colors.blue,
                          child: Text('Admin'),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, 'Admin');
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              primary: Colors.redAccent),
                          child: Text('Delete My Account'),
                          onPressed: () {
                            currState.api.delUser(currState.firebaseUser.uid);
                            currState.signOut();
                            Navigator.pushReplacementNamed(context, "Login");
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: MaterialButton(
                          color: Colors.redAccent,
                          onPressed: () {
                            currState.signOut();
                            Navigator.pushReplacementNamed(context, "Login");
                          },
                          child: Text("Log Out"),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Developed by:\nSyed Abdullah Muzaffar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      MaterialButton(
                        child: Text('View on PlayStore',
                            style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          //open playstore link
                        },
                      ),
                      MaterialButton(
                        child: Text('Rate Us',
                            style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          //open playstore link
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ),
        bottomNavigationBar: NavigationBar(index),
      ),
    );
  }
}
