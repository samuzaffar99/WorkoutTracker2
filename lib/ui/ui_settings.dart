import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_tracker2/services/login_api.dart';

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

  final currState = Get.find<Session>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.background,
        appBar: AppBar(
          // backgroundColor: theme.appBar,
          elevation: 5,
          title: Text("Settings"),
          centerTitle: true,
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
                              Text("Dark Mode",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
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
                              Text("Workout Alarm",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Switch(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            // color: Colors.blue,
                            child: Text('Admin'),
                            onPressed: () {
                              // Navigator.pop(context);
                              Navigator.pushNamed(context, 'Admin');
                            },
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                primary: Colors.redAccent),
                            child: Text('Delete My Account'),
                            onPressed: () {
                              currState.api.delUser(currState.firebaseUser.uid);
                              currState.signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "Login", (Route<dynamic> route) => false);
                              // Navigator.pushReplacementNamed(context, "Login");
                            },
                          ),
                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            child: Text(
                              'Log out',
                            ),
                            onPressed: () {
                              currState.signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "Login", (Route<dynamic> route) => false);
                              // Navigator.pushReplacementNamed(context, "Login");
                            },
                          ),
                        ],
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
                      TextButton(
                        child: Text('View on PlayStore',
                            style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          //open playstore link
                        },
                      ),
                      TextButton(
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
      ),
    );
  }
}
