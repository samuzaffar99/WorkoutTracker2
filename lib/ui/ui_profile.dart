import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker2/services/login_api.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePage();

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final bodyFatController = TextEditingController();
  final targetWeightController = TextEditingController();
  final targetBodyFatController = TextEditingController();
  final currState = Get.find<Session>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    weightController.dispose();
    heightController.dispose();
    bodyFatController.dispose();
    targetWeightController.dispose();
    targetBodyFatController.dispose();
    super.dispose();
  }

  Widget updateStats() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Update Profile Stats'),
      content: Form(
        // key: _formKey,
        child: Container(
          // height: double.maxFinite,
          width: 240,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text('Current Stats'),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Weight (kg)",
                    suffixText: "kg"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                  LengthLimitingTextInputFormatter(5)
                ],
                controller: weightController,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Height (cm)",
                    suffixText: "cm"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('([0-9]+(\.[0-9]+)?)')),
                  LengthLimitingTextInputFormatter(5)
                ],
                controller: heightController,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Body Fat (%)",
                    suffixText: "%"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('([0-9]+(\.[0-9]+)?)')),
                  LengthLimitingTextInputFormatter(5)
                ],
                controller: bodyFatController,
              ),
              SizedBox(height: 24),
              Text('Target Stats'),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Target Weight (kg)",
                    suffixText: "kg"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                  LengthLimitingTextInputFormatter(5)
                ],
                controller: targetWeightController,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Target Body Fat (%)",
                    suffixText: "%"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('([0-9]+(\.[0-9]+)?)')),
                  LengthLimitingTextInputFormatter(5)
                ],
                controller: targetBodyFatController,
              ),
              SizedBox(height: 10),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Save'),
                  onPressed: () async {
                    Map<String, dynamic> user = {};
                    user["height"] = heightController.text;
                    user["weight"] = weightController.text;
                    user["bodyFat"] = bodyFatController.text;
                    user["targetWeight"] = targetWeightController.text;
                    user["targetBodyFat"] = targetBodyFatController.text;
                    await currState.api
                        .putUser(currState.firebaseUser.uid, user);
                    await currState.fetchUser();
                    setState(() {});
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void changeName() {
  //   return;
  // }

  @override
  Widget build(BuildContext context) {
    // var _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.background,
        appBar: AppBar(
          // backgroundColor: theme.appBar,
          elevation: 5,
          title: Text("Profile"),
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return updateStats();
                          });
                    },
                    child: Icon(Icons.edit))),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 52.5,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(currState.userData["photoUrl"]),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      "${currState.userData["nickname"]}",
                      style: TextStyle(
                        fontSize: 24,
                        // color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
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
                                color: Colors.grey[200],
                                elevation: 4,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Weight",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(currState.userData
                                              .get("weight")
                                              .toString() +
                                          " kg"),
                                    ]),
                              ),
                            ),
                            Container(
                              height: 75,
                              width: 95,
                              child: Card(
                                color: Colors.grey[200],
                                elevation: 5,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Body Fat",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(currState.userData
                                              .get("bodyFat")
                                              .toString() +
                                          " %"),
                                    ]),
                              ),
                            ),
                            Container(
                              height: 75,
                              width: 95,
                              child: Card(
                                color: Colors.grey[200],
                                elevation: 5,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("BMI",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(""
                                          // calcBMI(
                                          //         double.parse(currState.userData
                                          //             .get("weight")),
                                          //         double.parse(currState.userData
                                          //             .get("height")))
                                          //     .toStringAsFixed(1),
                                          )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          'Your Goals',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 75,
                              width: 95,
                              child: Card(
                                color: Colors.grey[200],
                                elevation: 5,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Weight",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      // Text(currState.userData.get("targetWeight")+" kg"),
                                    ]),
                              ),
                            ),
                            Container(
                              height: 75,
                              width: 95,
                              child: Card(
                                color: Colors.grey[200],
                                elevation: 5,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Body Fat",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      // Text(currState.userData.get("targetBodyFat")+" %"),
                                    ]),
                              ),
                            ),
                            Container(
                              height: 75,
                              width: 95,
                              child: Card(
                                color: Colors.grey[200],
                                elevation: 5,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Days Remaining",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "${DateTime.now().difference(DateFormat('dd/MM/yyyy').parse("11/12/2021")).inDays}"),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(height: 30),
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
                            //Get.to(()=>HomePage());
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
                        SizedBox(height: 15),
                        TextButton.icon(
                          label: Text("Settings"),
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            Get.toNamed('/settings',id:1);
                          },
                        )
                      ],
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
