import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_tracker2/globals.dart';
// import '../others/animated_background.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:page_view_indicators/step_page_indicator.dart';
import 'package:intl/intl.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
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
  double targetWeight;
  double targetBodyFat;
  bool toggleLactose = false;
  bool toggleSugar = false;
  RangeValues _values = RangeValues(100, 900);
  final weekdays = List.filled(7, false);
  final List<String> workoutPlans = [
    "Home Exercise",
    "Power Lifting",
    "Body Building"
  ];
  final List<bool> workoutSelected = List.filled(3, false);
  // var _formKey = GlobalKey<FormState>();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final PageController pageController = PageController();
  final TextEditingController nameController =
      TextEditingController(text: currState.firebaseUser.displayName);
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void dispose() {
    _currentPageNotifier.dispose();
    pageController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

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

  void createWorkout() async {
    Map workout;
    Map workoutID = {
      "3DayPL": "2325423523",
      "4DayPL": "2325423523",
      "5DayPL": "2325423523",
    };
    user["currWorkout"] = await currState.api.postWorkout(workout);
    return;
  }

  void createDiet() async {
    Map diet;
    Map dietID = {
      "3DayPL": "2325423523",
      "4DayPL": "2325423523",
      "5DayPL": "2325423523",
    };
    user["currDiet"] = await currState.api.postDiet(diet);
    return;
  }

  _selectDate() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (date != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(date);
      });
    }
  }

  _selectTime() async {
    final TimeOfDay time = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (time != null) {
      setState(() {
        timeController.text = time.format(context);
      });
    }
  }

  List<DropdownMenuItem<String>> generateDropdownItems(List<String> ddl) {
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  Widget infoPage() {
    List<String> genders = ["Male", "Female"];
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 12),
        Text("Basic Info", textScaleFactor: 3),
        Container(
          width: 320,
          height: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "What should we call you?",
                    prefixIcon: Icon(Icons.person),
                  ),
                  controller: nameController,
                  inputFormatters: [LengthLimitingTextInputFormatter(24)]),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Gender"),
                value: genders[0],
                items: generateDropdownItems(genders),
                onChanged: (val) {
                  setState(
                    () {
                      gender = val;
                    },
                  );
                },
              ),
              OutlinedButton(
                child: TextField(
                  decoration: InputDecoration(labelText: "Date of Birth"),
                  textAlign: TextAlign.center,
                  controller: dateController,
                  enabled: false,
                ),
                onPressed: () {
                  _selectDate();
                },
              ),
            ],
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [nextButton()],
        ),
      ],
    );
  }

  Widget statsPage() {
    List<String> plans = ["Lose Fat", "Gain Muscle", "Maintain Weight"];
    String goal;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 12),
        Text("Current Stats", textScaleFactor: 3),
        Container(
          width: 400,
          padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Weight (kg)",
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                LengthLimitingTextInputFormatter(5)
              ],
              onChanged: (value) => weight = double.parse(value),
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Height (cm)",
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('([0-9]+(\.[0-9]+)?)')),
                LengthLimitingTextInputFormatter(5)
              ],
              onChanged: (value) => height = double.parse(value),
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Body Fat (%)",
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('([0-9]+(\.[0-9]+)?)')),
                LengthLimitingTextInputFormatter(5)
              ],
              onChanged: (value) => bodyFat = double.parse(value),
            ),
          ]),
        ),
        Text(
          "Select your Goals",
          textScaleFactor: 3,
        ),
        Container(
            width: 400,
            padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: Column(children: [
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Goals"),
                value: plans[0],
                items: generateDropdownItems(plans),
                onChanged: (val) {
                  setState(
                    () {
                      goal = val;
                    },
                  );
                },
              ),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Target Weight (kg)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                  LengthLimitingTextInputFormatter(5)
                ],
                onChanged: (value) => targetWeight = double.parse(value),
              ),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Target Body Fat (%)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('([0-9]+(\.[0-9]+)?)')),
                  LengthLimitingTextInputFormatter(5)
                ],
                onChanged: (value) => targetBodyFat = double.parse(value),
              ),
            ])),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [prevButton(), SizedBox(width: 24), nextButton()],
        ),
      ],
    );
  }

  Widget workoutPage() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          Text('Select a Training Plan', textScaleFactor: 3),
          Container(
              width: 320,
              height: 640,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(height: 24),
                  Container(
                    height: 160,
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 12);
                        },
                        itemCount: workoutPlans.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new MaterialButton(
                            color: workoutSelected[index]
                                ? Colors.orange
                                : Colors.white,
                            elevation: 5,
                            height: 48,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            onPressed: () {
                              setState(() {
                                workoutSelected.fillRange(
                                    0, workoutSelected.length, false);
                                workoutSelected[index] =
                                    !workoutSelected[index];
                              });
                            },
                            child: new Text(workoutPlans[index]),
                          );
                        }),
                  ),
                  Text('Select Workout Days', textScaleFactor: 2),
                  WeekdaySelector(
                    onChanged: (int day) {
                      setState(() {
                        final index = day % 7;
                        weekdays[index] = !weekdays[index];
                      });
                    },
                    values: weekdays,
                  ),
                  OutlinedButton(
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.alarm),
                          labelText: "Select Workout Start Time"),
                      textAlign: TextAlign.center,
                      controller: timeController,
                      enabled: false,
                    ),
                    onPressed: () {
                      _selectTime();
                    },
                  ),
                ],
              )),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [prevButton(), SizedBox(width: 24), nextButton()],
          ),
        ]);
  }

  Widget dietPage() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Select Macros",
            textScaleFactor: 2,
          ),
          SizedBox(height: 55),
          //Insert Pie chart here
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              "Fat",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "|",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Protein",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "|",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Carbs",
              style: TextStyle(fontSize: 20),
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
            children: <Widget>[prevButton(), SizedBox(width: 24), nextButton()],
          ),
        ]);
  }

  Widget finishPage() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          Container(
              width: 480,
              height: 640,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("You're all done now!", textScaleFactor: 3),
                Text(
                    "Press Finish to complete your registration or go back to modify your details",
                    textScaleFactor: 1.5),
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              prevButton(),
              SizedBox(width: 24),
              finishButton()
            ],
          ),
        ]);
  }

  Widget prevButton() {
    return Container(
      // height: 36,
      width: 280,
      child: ElevatedButton.icon(
          onPressed: prevPage,
          style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              elevation: 5,
              textStyle: TextStyle(
                fontSize: 24,
              ),
              padding: EdgeInsets.fromLTRB(8, 16, 8, 16)
              // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
          icon: Icon(Icons.arrow_back),
          label: const Text('Previous')),
    );
  }

  Widget nextButton() {
    return Container(
      // height: 36,
      width: 280,
      child: ElevatedButton.icon(
          onPressed: nextPage,
          style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent,
              elevation: 5,
              textStyle: TextStyle(
                fontSize: 24,
              ),
              padding: EdgeInsets.fromLTRB(8, 16, 8, 16)),
          icon: Icon(Icons.arrow_forward),
          label: const Text('Next')),
    );
  }

  Widget finishButton() {
    return Container(
      // height: 36,
      width: 280,
      child: ElevatedButton.icon(
          onPressed: () async {
            await _registerUser();
            Navigator.pushReplacementNamed(context, "Home");
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent,
              elevation: 5,
              textStyle: TextStyle(
                fontSize: 24,
              ),
              padding: EdgeInsets.fromLTRB(8, 16, 8, 16)),
          icon: Icon(Icons.thumb_up),
          label: const Text('Finish')),
    );
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
