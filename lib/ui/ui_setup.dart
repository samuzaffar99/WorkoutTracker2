import 'package:flutter/material.dart';
import 'package:workout_tracker2/ui/ui_setup_details.dart';
// import 'package:workout_tracker2/deprecated/pages/ui_setup_details.dart';
// import '../others/animated_background.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

// Text("What should we call you?")
// hintText : "enter your nickname"
class _SetupPageState extends State<SetupPage> {
  String username;
  bool checku = true;
  bool checkm = true;
  var _formKey = GlobalKey<FormState>();

  Future<bool> _signupUser() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFF141414),
            body: Container(
              height: double.infinity,
              child: Stack(
                children: [
                  PageView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    children: const <Widget>[
                      Center(
                        child: Text('First Page'),
                      ),
                      Center(
                        child: Text('Second Page'),
                      ),
                      Center(
                        child: Text('Third Page'),
                      )
                    ],
                  ),
                  Positioned.fill(child: Center()),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment(0, 1.1),
                          children: [
                            // Image.asset(
                            //   'assets/images/pic6.jpg',
                            // ),
                            Text(
                              'Create a New Account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 27,
                                color: Colors.white.withAlpha(220),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    IconTheme(
                                      child: Icon(Icons.person),
                                      data: IconThemeData(color: Colors.white),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: 20, left: 10),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            hintText: "enter your nickname",
                                            filled: true,
                                            fillColor:
                                                Colors.white.withAlpha(200),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Username cannot be left blank";
                                            } else if (checku == false) {
                                              setState(
                                                () {
                                                  checku = true;
                                                },
                                              );
                                              return "Username already exists";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            username = value;
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonTheme(
                              height: 45.0,
                              minWidth: 200.0,
                              child: OutlinedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    await _signupUser().then(
                                      (value) {
                                        print('$value');
                                        if (value == true) {
                                        } else {
                                          setState(
                                            () {
                                              checku = false;
                                            },
                                          );
                                        }
                                      },
                                    );
                                    if (checku == true && checkm == true) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return DetailsPage();
                                          },
                                        ),
                                      );
                                    }
                                    _formKey.currentState.validate();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Continue",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white.withAlpha(220),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
