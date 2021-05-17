import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:workout_tracker2/ui/setup/ui_setup_details.dart';
// import '../others/animated_background.dart';
import 'package:weekday_selector/weekday_selector.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  Map user = {
    "nickname": "",
    "gender": "",
    "height": "",
    "weight": "",
    "bodyFat": "",
    "birthDate": ""
  };
  String nickname;
  String gender;
  double height;
  double weight;
  double bodyFat;
  String date;
  bool checku = true;
  var _formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  final TextEditingController nameController =
      TextEditingController(text: currState.firebaseUser.displayName);

  Future<bool> _registerUser() async {
    user["nickName"] = nickname;
    user["gender"] = gender;
    user["height"] = height;
    user["weight"] = weight;
    user["bodyFat"] = bodyFat;
    await currState.api.postUser(user);
  }

  Widget namePage() {
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
            ])
      ],
    );
    // ,
    //   Container(
    //   child: Form(
    //     key: _formKey,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: Row(
    //             children: <Widget>[
    //               IconTheme(
    //                 child: Icon(Icons.person),
    //                 data: IconThemeData(color: Colors.white),
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   margin: EdgeInsets.only(right: 20, left: 10),
    //                   child: TextFormField(
    //                     decoration: InputDecoration(
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(20)),
    //                         borderSide: BorderSide(
    //                           color: Colors.transparent,
    //                         ),
    //                       ),
    //                       hintText: "enter your nickname",
    //                       filled: true,
    //                       fillColor: Colors.white.withAlpha(200),
    //                     ),
    //                     validator: (value) {
    //                       if (value.isEmpty) {
    //                         return "Username cannot be left blank";
    //                       } else if (checku == false) {
    //                         setState(
    //                           () {
    //                             checku = true;
    //                           },
    //                         );
    //                       }
    //                       return null;
    //                     },
    //                     onSaved: (value) {
    //                       name = value;
    //                     },
    //                   ),
    //                 ),
    //               ),
  }

  Widget detailsPage() {
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
                    decoration: InputDecoration(
                        filled: true, fillColor: Colors.white.withAlpha(200))),
              ),
            ])
      ],
    );
  }

  Widget goalsPage() {
    List<DropdownMenuItem<String>> genderDropdown() {
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
          items: genderDropdown(),
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
      ],
    );
  }

  Widget workoutPage() {
    final values = List.filled(7, false);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Select a Training Plan'),
          Text('Select Workout Days'),
          WeekdaySelector(
            onChanged: (int day) {
              setState(() {
                // Use module % 7 as Sunday's index in the array is 0 and
                // DateTime.sunday constant integer value is 7.
                final index = day % 7;
                // We "flip" the value in this example, but you may also
                // perform validation, a DB write, an HTTP call or anything
                // else before you actually flip the value,
                // it's up to your app's needs.
                values[index] = !values[index];
              });
            },
            values: values,
          ),
          Text('Select Workout Start Time'),
          Text('Select Workout Type'),
        ]);
  }

  Widget dietPage() {
    return;
  }

  Widget finishPage() {
    return;
  }

  void previousPage() {
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
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                    onPressed: previousPage, child: Text('Previous')),
                MaterialButton(onPressed: nextPage, child: Text('Next'))
              ],
            ),
            body: PageView(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              children: [
                namePage(),
                detailsPage(),
                goalsPage(),
                workoutPage(),
                dietPage(),
                finishPage(),
                Center(child: Text('Third Page')),
                Center(child: Text('Third Page'))
              ],
            )));
  }
}
