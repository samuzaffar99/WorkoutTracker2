import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_tracker2/globals.dart';
// import '../others/animated_background.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:page_view_indicators/step_page_indicator.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final _currentPageNotifier = ValueNotifier<int>(0);
  final Map<String, dynamic> user = {
    "nickname": "",
    "gender": "",
    "height": "",
    "weight": "",
    "bodyFat": "",
    "birthDate": ""
  };
  Future<TimeOfDay> workoutTime;
  String gender;
  double height;
  double weight;
  double bodyFat;
  String date;
  bool toggleLactose = false;
  bool toggleSugar = false;
  RangeValues _values = RangeValues(100, 900);
  final weekdays = List.filled(7, false);
  bool checku = true;
  // var _formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  final TextEditingController nameController =
      TextEditingController(text: currState.firebaseUser.displayName);
  final TextEditingController dateController = TextEditingController();
  Future<bool> _registerUser() async {
    user["photoUrl"] = currState.firebaseUser.photoURL;
    user["id"] = currState.firebaseUser.uid;
    user["email"] = currState.firebaseUser.email;
    user["createdAt"] = DateTime.now().millisecondsSinceEpoch.toString();
    user["nickname"] = nameController.text;
    user["gender"] = gender;
    user["height"] = height;
    user["weight"] = weight;
    user["bodyFat"] = bodyFat;
    await currState.createUser(user);
    return await currState.initializeUser();
  }

  _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != date)
      setState(() {
        date = picked.toString();
      });
    setState(() {
      dateController.text = picked.toString();
      // TextEditingController(text: '${myFormat.format(selectedDate)}');
    });
  }

  Widget infoPage() {
    List<DropdownMenuItem<String>> genderDropdown() {
      List<String> ddl = ["Male", "Female"];
      return ddl
          .map((value) => DropdownMenuItem(
        value: value,
        child: Text(value),
      ))
          .toList();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "What should we call you?",
          textScaleFactor: 2,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Container(
                constraints: BoxConstraints.tight(const Size(240, 48)),
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                    controller: nameController,
                    decoration:
                        InputDecoration(filled: true, fillColor: Colors.grey)),
              ),
            ]),
        Text(
          "Select your Gender",
          textScaleFactor: 2,
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            filled: true,
            fillColor: Colors.white.withAlpha(200),
          ),
          value: gender,
          items: genderDropdown(),
          onChanged: (val) {
            setState(
                  () {
                gender = val;
              },
            );
          },
        ),
        MaterialButton(
          child: Text('Enter your Date of Birth'),
          onPressed: () {
            _selectDate();
          },
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [MaterialButton(onPressed: nextPage, child: Text('Next'))],
        ),
      ],
    );
  }

  Widget statsPage() {
    List<DropdownMenuItem<String>> goalDropdown() {
      List<String> ddl = ["Lose Fat", "Gain Muscle", "Maintain Weight"];
      return ddl
          .map((value) => DropdownMenuItem(
                value: value,
                child: Text(value),
              ))
          .toList();
    }

    String goal;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Weight (kg)",
          textScaleFactor: 2,
        ),
        TextFormField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
          ],
          // onChanged: (value) => doubleVar = double.parse(value),
        ),
        Text("Height (cm)", textScaleFactor: 2),
        TextFormField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('([0-9]+(\.[0-9]+)?)')),
          ],
          // onChanged: (value) => doubleVar = double.parse(value),
        ),
        Text("Body Fat (%)", textScaleFactor: 2),
        TextFormField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('([0-9]+(\.[0-9]+)?)')),
          ],
          onChanged: (value) => bodyFat = double.parse(value),
        ),
        Text(
          "Select your Goal",
          textScaleFactor: 2,
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            filled: true,
            fillColor: Colors.white.withAlpha(200),
          ),
          value: goal,
          items: goalDropdown(),
          onChanged: (val) {
            setState(
              () {
                goal = val;
              },
            );
          },
        ),
        Text(
          "Target Weight (kg)",
          textScaleFactor: 2,
        ),
        TextFormField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
          ],
          // onChanged: (value) => doubleVar = double.parse(value),
        ),
        Text("Target Body Fat (%)", textScaleFactor: 2),
        TextFormField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('([0-9]+(\.[0-9]+)?)')),
          ],
          onChanged: (value) => bodyFat = double.parse(value),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MaterialButton(onPressed: prevPage, child: Text('Previous')),
            MaterialButton(onPressed: nextPage, child: Text('Next'))
          ],
        ),
      ],
    );
  }

  Widget workoutPage() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Select a Training Plan'),
          Text('Select Workout Days'),
          WeekdaySelector(
            // selectedFillColor: Colors.indigo,
            onChanged: (int day) {
              setState(() {
                // Use module % 7 as Sunday's index in the array is 0 and
                // DateTime.sunday constant integer value is 7.
                final index = day % 7;
                // We "flip" the value in this example, but you may also
                // perform validation, a DB write, an HTTP call or anything
                // else before you actually flip the value,
                // it's up to your app's needs.
                weekdays[index] = !weekdays[index];
              });
            },
            values: weekdays,
          ),
          MaterialButton(
            child: Text('Select Workout Start Time'),
            onPressed: () {
              workoutTime = showTimePicker(
                  initialTime: TimeOfDay.now(), context: context);
            },
          ),
          Text('Select Workout Type'),
          MaterialButton(
            child: Text("Home Exercise",
                // style: TextStyle(color: Colors.white.withAlpha(200)),
            ),
            onPressed: null,
          ),
          MaterialButton(
            child: Text("Power Lifting",
                // style: TextStyle(color: Colors.white.withAlpha(200)),
            ),
            onPressed: null,
          ),
          MaterialButton(
            child: Text(
              "Body Building",
              // style: TextStyle(color: Colors.white.withAlpha(200)),
            ),
            onPressed: null,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MaterialButton(onPressed: prevPage, child: Text('Previous')),
              MaterialButton(onPressed: nextPage, child: Text('Next'))
            ],
          ),
        ]);
  }

  Widget dietPage() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "What should we call you?",
            textScaleFactor: 2,
          ),
          SizedBox(height: 55),
          //Insert Pie chart here
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              "Fat",
              style: TextStyle(
                  fontSize: 20),
            ),
            Text(
              "|",
              style: TextStyle(
                  fontSize: 20),
            ),
            Text(
              "Protein",
              style: TextStyle(
                  fontSize: 20),
            ),
            Text(
              "|",
              style: TextStyle(
                  fontSize: 20),
            ),
            Text(
              "Carbs",
              style: TextStyle(
                  fontSize: 20),
            ),
          ]),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 25,
              rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 18, pressedElevation: 20, elevation: 30),
              showValueIndicator: ShowValueIndicator.never,
            ),
            child: RangeSlider(
              divisions: 6,
              values: _values,
              min: 0,
              max: 1000,
              labels: RangeLabels(
                  '${_values.start.round()}', '${_values.end.round()}'),
              onChanged: (RangeValues values) {
                setState(() {
                  _values = values;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "   Lactose Free",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                    ),
                  ),
                ],
              ),
              Switch(
                // activeTrackColor: Colors.green[10],
                // activeColor: Colors.green,
                value: toggleLactose,
                onChanged: (value) {
                  setState(() {
                    toggleLactose = value;
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
                    "   Sugar Free",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        // color: Colors.white.withAlpha(230),
                        // fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              Switch(
                // inactiveTrackColor: Colors.white.withAlpha(230),
                // inactiveThumbColor: Colors.white.withAlpha(230),
                // activeTrackColor: Colors.green[10],
                // activeColor: Colors.green,
                value: toggleSugar,
                onChanged: (value) {
                  setState(() {
                    toggleSugar = value;
                  });
                },
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              MaterialButton(onPressed: prevPage, child: Text('Previous')),
              MaterialButton(onPressed: nextPage, child: Text('Next'))
            ],
          ),
        ]);
  }

  Widget finishPage() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("You're all done now!"),
          Text(
              "Press Finish to complete your registration or go back to modify your details"),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              MaterialButton(onPressed: prevPage, child: Text('Previous')),
              MaterialButton(
                  onPressed: () async {
                    await _registerUser();
                    Navigator.pushReplacementNamed(context, "Home");
                  },
                  child: Text('Finish'))
            ],
          ),
        ]);
  }

  void prevPage() {
    pageController.previousPage(
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void nextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: theme.appBar,
              elevation: 5,
              title: Text("User Setup"),
            ),
            body: Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStepIndicator(),
                Expanded(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: pageController,
                    onPageChanged: (int index) {
                      _currentPageNotifier.value = index;
                    },
                    children: [
                      infoPage(),
                      statsPage(),
                      workoutPage(),
                      dietPage(),
                      finishPage(),
                    ],
                  ),
                ),
              ],
            )));
  }

  _buildStepIndicator() {
    return Container(
      // color: Colors.black,
      padding: const EdgeInsets.all(16.0),
      child: StepPageIndicator(
        itemCount: 4,
        currentPageNotifier: _currentPageNotifier,
        size: 16,
        onPageSelected: (int index) {
          if (_currentPageNotifier.value > index)
            pageController.jumpToPage(index);
        },
      ),
    );
  }
}
