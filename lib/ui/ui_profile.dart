import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
import 'ui_navbar.dart';
import 'ui_settings.dart';
// import '../deprecated/src/model.dart';
import 'package:intl/intl.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePage();
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final weightController = TextEditingController();
  final bodyfatController = TextEditingController();
  final weightgController = TextEditingController();
  final bodyfatgController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    weightController.dispose();
    bodyfatController.dispose();
    weightgController.dispose();
    bodyfatgController.dispose();
    super.dispose();
  }
  void updateGoals(){
    return;
  }
  void updateCurrentStats(){
    return;
  }
  void changeName(){
    return;
  }
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    int index = 4;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF141414),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 5,
          title: Text("Profile"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[350],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text(
                                'Edit Profile',
                                style: TextStyle(fontSize: 23),
                              ),
                              content: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Enter your current weight'),
                                    SizedBox(height: 5),
                                    TextFormField(
                                      controller: weightController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: '75.0kg',
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text('Enter your current bodyfat'),
                                    SizedBox(height: 5),
                                    TextFormField(
                                      controller: bodyfatController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: '15.0 %',
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text('Enter your desired weight'),
                                    SizedBox(height: 5),
                                    TextFormField(
                                      controller: weightgController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: '50.0 kg',
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text('Enter your desired bodyfat'),
                                    SizedBox(height: 5),
                                    TextFormField(
                                      controller: bodyfatgController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: '10.0 %',
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          minWidth: 100,
                                          height: 50,
                                          color: Colors.grey,
                                          child: Text('Save'),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          onPressed: () {
                                            // widget.user.stats.weight=double.parse(weightController.text);
                                            // widget.user.stats.bodyfat=double.parse(bodyfatController.text);
                                            // widget.user.goals.weight=double.parse(weightgController.text);
                                            // widget.user.goals.bodyfat=double.parse(bodyfatgController.text);
                                            // _api.putUser(widget.user);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Icon(Icons.edit))),
          ],
        ),
        bottomNavigationBar:  NavigationBar(index),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 52.5,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(currState.userData["photoUrl"]),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "${currState.userData["nickname"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Opacity(
                  opacity: 0.5,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 75,
                                width: 95,
                                child: Card(
                                  color: Colors.grey[300],
                                  elevation: 4,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "70 kg\n",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "Weight",
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 75,
                                width: 95,
                                child: Card(
                                  color: Colors.grey[300],
                                  elevation: 4,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "Yeet %\n",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "BodyFat",
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 75,
                                width: 95,
                                child: Card(
                                  color: Colors.grey[300],
                                  elevation: 4,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "12\n",
                                                // text: "${calcBMI(11, 12)}\n",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "BMI",
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Text(
                            'Your Goals',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 75,
                                width: 95,
                                child: Card(
                                  color: Colors.grey[300],
                                  elevation: 4,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "74 kg\n",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "Weight",
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 75,
                                width: 95,
                                child: Card(
                                  color: Colors.grey[300],
                                  elevation: 4,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "12 %\n",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "BodyFat",
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 75,
                                width: 95,
                                child: Card(
                                  color: Colors.grey[300],
                                  elevation: 4,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "      ${DateTime.now().difference(DateFormat('dd/MM/yyyy').parse("11/12/2021")).inDays}\n",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "Days Rem",
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 30,
                            ),
                          ),
                          Text(
                            '7 Day Streak',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //Navigator.pop(context);
                              //Insert new navigation page here
                            },
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'View last session',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                    onPressed: () {
                                      // Navigator.pop(context);
                                      Navigator.pushNamed(context, "Settings");
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.settings),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text('Settings'),
                                              ),
                                            ]))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
