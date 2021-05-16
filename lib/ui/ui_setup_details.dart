import 'package:flutter/material.dart';
// import 'package:workout_tracker2/ui/ui_setup_goals.dart';

// import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/services.dart';

import 'package:workout_tracker2/globals.dart';
// import 'package:crypt/crypt.dart';
// import '../others/animated_background.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage();
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String gender;
  double height;
  double weight;
  double bodyfat;
  String date;

  var _formKey = GlobalKey<FormState>();

  // void _registerUser() {
  //   print('called registeruser');
  //   User newUser = User.fromJson({
  //     'username': widget.username,
  //     'hash': Crypt.sha512(widget.password).toString(),
  //     'email': widget.email,
  //     'gender': gender,
  //     'birthdate': date,
  //     'stats': {'height': height, 'weight': weight, "bodyfat": 0},
  //     "goals": {"targetdate": "12/12/2001", "weight": 60.0, "bodyfat": 24.0}
  //   });
  //   print('new User to add: ${newUser.toJson()}');
  //   currState.api.postUser(newUser).then(
  //     (value) {
  //       print('${value.username} is now registered');
  //     },
  //   );
  //   print('returning from register user');
  //   return;
  // }

  String selectGender;
  DateTime selectedDate;
  // var myFormat = DateFormat('dd/MM/yyyy');
  var myController;

  List<DropdownMenuItem<String>> genderDropdown() {
    List<String> ddl = ["Male", "Female"];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    setState(() {
      myController = TextEditingController(text: '$selectedDate');
      // TextEditingController(text: '${myFormat.format(selectedDate)}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF141414),
        body: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(child: Center()),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment(0, 1.2),
                      children: [
                        // Image.asset(
                        //   'assets/images/pic4.jpg',
                        //   width: 260,
                        // ),
                        Text(
                          'Enter Details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white.withAlpha(220),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white.withAlpha(200),
                                      ),
                                      value: selectGender,
                                      items: genderDropdown(),
                                      validator: (value) => value == null
                                          ? 'Please select your gender'
                                          : null,
                                      onChanged: (value) {
                                        selectGender = value;
                                        setState(() {
                                          gender = value;
                                        });
                                      },
                                      hint: Text("Gender"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: 'Weight (kg)',
                                        filled: true,
                                        fillColor: Colors.white.withAlpha(200),
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please enter your weight";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        weight = double.parse(value);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        hintText: 'Height (cm)',
                                        filled: true,
                                        fillColor: Colors.white.withAlpha(200),
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please enter your height";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        height = double.parse(value);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                    child: InkWell(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: IgnorePointer(
                                        child: TextFormField(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            hintText: 'Date of Birth',
                                            filled: true,
                                            fillColor:
                                                Colors.white.withAlpha(200),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Please enter your date of birth";
                                            }
                                            return null;
                                          },
                                          controller: myController,
                                        ),
                                      ),
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
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          height: 45.0,
                          minWidth: 200.0,
                          child: OutlinedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                // _registerUser();
                                Navigator.pushNamed(
                                  context,"Home"
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Next",
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
        ),
      ),
    );
  }
}
