import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:workout_tracker2/ui/ui_navbar.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage();
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool toggleDark = false;
  bool toggleAlarm = false;
  final nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = 4;
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          backgroundColor: theme.appBar,
          elevation: 5,
          title: Text("Settings"),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: Opacity(
                  opacity: 0.5,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          height: 400,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "   Dark Mode",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Switch(
                                      inactiveThumbColor: Colors.white,
                                      activeTrackColor: Colors.green[10],
                                      activeColor: Colors.green,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "   Workout Alarm",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Switch(
                                      inactiveThumbColor: Colors.white,
                                      activeTrackColor: Colors.green[10],
                                      activeColor: Colors.green,
                                      value: toggleAlarm,
                                      onChanged: (value) {
                                        setState(() {
                                          toggleAlarm = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                MaterialButton(
                                  child: Text('Delete My Account'),
                                  onPressed: () {
                                    currState.api.delUser(currState.firebaseUser.uid);
                                    currState.signOut();
                                    Navigator.pushReplacementNamed(context, "Login");
                                  },
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                MaterialButton(
                                  height: 40,
                                  color: Colors.blue[400],
                                  child: Text('Admin'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, 'Admin');
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonTheme(
                                      height: 45.0,
                                      minWidth: 150.0,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          currState.signOut();
                                          Navigator.pushReplacementNamed(context, "Login");
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Log Out",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
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
                                  child: Text('View on PlayStore',style: TextStyle(color: Colors.blue)),
                                  onPressed: () {
                                    //open playstore link
                                  },
                                ),
                                MaterialButton(
                                  child: Text('Rate Us',style: TextStyle(color: Colors.blue)),
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
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(index),
      ),
    );
  }
}
