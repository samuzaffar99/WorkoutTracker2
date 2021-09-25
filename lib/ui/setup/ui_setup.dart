import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:intl/intl.dart';

import 'package:weekday_selector/weekday_selector.dart';
import 'package:page_view_indicators/step_page_indicator.dart';
import 'package:pie_chart/pie_chart.dart';

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
  Future<TimeOfDay>? workoutTime;
  String gender = "Male";
  double? height;
  double? weight;
  double? bodyFat;
  double? targetWeight;
  double? targetBodyFat;
  String? goal;
  bool toggleLactose = false;
  bool toggleSugar = false;
  Map<String, double> macroPct = {"Fat": 30, "Protein": 30, "Carbs": 40};
  RangeValues _values = RangeValues(30, 60);
  final weekdays = List.filled(7, false);
  final List<String> workoutPlans = [
    "Home Exercise",
    "Power Lifting",
    "Body Building"
  ];
  final List<String> genders = ["Male", "Female"];
  final List<String> plans = ["Lose Fat", "Gain Muscle", "Maintain Weight"];
  final List<bool> workoutSelected = [true, false, false];
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
    user["birthDate"] = dateController.text;
    await currState.createUser(user);
    return await currState.initializeUser();
  }

  // void createWorkout() async {
  //   Map workout;
  //   Map workoutID = {
  //     "3DayPL": "2325423523",
  //     "4DayPL": "2325423523",
  //     "5DayPL": "2325423523",
  //   };
  //   user["currWorkout"] = await currState.api.postWorkout(workout);
  //   return;
  // }
  //
  // void createDiet() async {
  //   Map diet;
  //   Map dietID = {
  //     "3DayPL": "2325423523",
  //     "4DayPL": "2325423523",
  //     "5DayPL": "2325423523",
  //   };
  //   user["currDiet"] = await currState.api.postDiet(diet);
  //   return;
  // }

  _selectDate() async {
    final DateTime? date = await showDatePicker(
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
    final TimeOfDay? time = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (time != null) {
      setState(() {
        timeController.text = time.format(context);
      });
    }
  }

  Widget infoPage() {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 320,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
            child: ListView(
              children: [
                Text("Basic Info",
                    textScaleFactor: 2, textAlign: TextAlign.center),
                SizedBox(height: 24),
                TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "What should we call you?",
                      prefixIcon: Icon(Icons.person),
                    ),
                    controller: nameController,
                    inputFormatters: [LengthLimitingTextInputFormatter(24)]),
                SizedBox(height: 24),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Gender"),
                  value: genders[0],
                  items: generateDropdownItems(genders),
                  onChanged: (val) {
                    setState(
                      () {
                        gender = val.toString();
                      },
                    );
                  },
                ),
                SizedBox(height: 24),
                OutlinedButton(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Date of Birth"),
                    textAlign: TextAlign.center,
                    controller: dateController,
                    enabled: false,
                  ),
                  onPressed: () => _selectDate(),
                ),
              ],
            ),
          ),
        ),
        Row(children: [nextButton()]),
      ],
    );
  }

  Widget statsPage() {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 320,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
            child: ListView(
              children: [
                Text("Current Stats", textScaleFactor: 2),
                SizedBox(height: 24),
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
                  onChanged: (value) => weight = double.parse(value),
                ),
                SizedBox(height: 24),
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
                  onChanged: (value) => height = double.parse(value),
                ),
                SizedBox(height: 24),
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
                  onChanged: (value) => bodyFat = double.parse(value),
                ),
                SizedBox(height: 24),
                Text(
                  "Select your Goals",
                  textScaleFactor: 2,
                ),
                SizedBox(height: 24),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Goals"),
                  value: plans[0],
                  items: generateDropdownItems(plans),
                  onChanged: (val) {
                    setState(
                      () {
                        goal = val.toString();
                      },
                    );
                  },
                ),
                SizedBox(height: 24),
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
                  onChanged: (value) => targetWeight = double.parse(value),
                ),
                SizedBox(height: 24),
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
                  onChanged: (value) => targetBodyFat = double.parse(value),
                ),
              ],
            ),
          ),
        ),
        Row(children: [prevButton(), nextButton()]),
      ],
    );
  }

  Widget workoutPage() {
    return Column(children: [
      Expanded(
        child: Container(
            width: 320,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
            child: ListView(
              children: [
                SizedBox(height: 12),
                Text('Select a Training Plan',
                    textScaleFactor: 2, textAlign: TextAlign.center),
                SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                              workoutSelected[index] = true;
                              // !workoutSelected[index];
                            });
                          },
                          child: new Text(workoutPlans[index]),
                        );
                      }),
                ),
                SizedBox(height: 36),
                Text('Select Workout Days',
                    textScaleFactor: 2, textAlign: TextAlign.center),
                SizedBox(height: 12),
                WeekdaySelector(
                  onChanged: (int day) {
                    setState(() {
                      final index = day % 7;
                      weekdays[index] = !weekdays[index];
                    });
                  },
                  values: weekdays,
                ),
                SizedBox(height: 24),
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
      ),
      Row(children: [prevButton(), nextButton()]),
    ]);
  }

  Widget dietPage() {
    return Column(children: [
      Expanded(
        child: Container(
          width: 320,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: ListView(
            children: [
              Text("Select Macros",
                  textScaleFactor: 2, textAlign: TextAlign.center),
              SizedBox(height: 24),
              Container(
                  width: 240, height: 240, child: PieChart(dataMap: macroPct)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Fat", style: TextStyle(fontSize: 16)),
                  VerticalDivider(),
                  Text("Protein", style: TextStyle(fontSize: 16)),
                  VerticalDivider(),
                  Text("Carbs", style: TextStyle(fontSize: 16)),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 24,
                  rangeThumbShape: RoundRangeSliderThumbShape(
                      enabledThumbRadius: 18,
                      pressedElevation: 20,
                      elevation: 30),
                  showValueIndicator: ShowValueIndicator.never,
                ),
                child: RangeSlider(
                  activeColor: Colors.blueAccent,
                  inactiveColor: Colors.blue,
                  divisions: 20,
                  values: _values,
                  min: 0,
                  max: 100,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _values = RangeValues(
                          max(20, values.start), min(80, values.end));
                      macroPct["Fat"] = _values.start;
                      macroPct["Protein"] = _values.end - _values.start;
                      macroPct["Carbs"] = 100 - _values.end;
                    });
                  },
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Lactose Free", style: TextStyle(fontSize: 18)),
                  Switch(
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
                  Text("Sugar Free", style: TextStyle(fontSize: 18)),
                  Switch(
                    value: toggleSugar,
                    onChanged: (value) {
                      setState(() {
                        toggleSugar = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Row(children: <Widget>[prevButton(), nextButton()]),
    ]);
  }

  Widget finishPage() {
    return Column(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("You're all done now!",
                  textScaleFactor: 3, textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Press Finish to complete your registration or go back to modify your details",
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Row(children: [prevButton(), finishButton()]),
    ]);
  }

  Widget prevButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: ElevatedButton.icon(
            onPressed: prevPage,
            style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                textStyle: TextStyle(fontSize: 24),
                padding: EdgeInsets.fromLTRB(8, 16, 8, 16)),
            icon: Icon(Icons.arrow_back),
            label: const Text('Previous')),
      ),
    );
  }

  Widget nextButton() {
    return Expanded(
      // width: 280,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: ElevatedButton.icon(
            onPressed: nextPage,
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              textStyle: TextStyle(fontSize: 24),
              padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
            ),
            icon: Icon(Icons.arrow_forward),
            label: const Text('Next')),
      ),
    );
  }

  Widget finishButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: ElevatedButton.icon(
            onPressed: () async {
              await _registerUser();
              Navigator.pushReplacementNamed(context, "Home");
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                elevation: 5,
                textStyle: TextStyle(
                  fontSize: 24,
                ),
                padding: EdgeInsets.fromLTRB(8, 16, 8, 16)),
            icon: Icon(Icons.thumb_up),
            label: const Text('Finish')),
      ),
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
            // backgroundColor: Colors.white,
            appBar: AppBar(
              // backgroundColor: theme.appBar,
              elevation: 5,
              title: Text("User Setup"),
              centerTitle: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStepIndicator(),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.horizontal,
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
      padding: const EdgeInsets.all(16.0),
      child: StepPageIndicator(
        itemCount: 4,
        currentPageNotifier: _currentPageNotifier,
        size: 20,
        onPageSelected: (int index) {
          if (_currentPageNotifier.value > index)
            pageController.jumpToPage(index);
        },
      ),
    );
  }
}
