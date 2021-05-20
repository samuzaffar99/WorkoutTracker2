import 'package:flutter/material.dart';
import 'package:workout_tracker2/ui/ui_navbar.dart';
import 'package:workout_tracker2/ui/workout/ui_edit_workout.dart';
import 'package:workout_tracker2/ui/workout/ui_in_workout.dart';
import 'package:workout_tracker2/globals.dart';

// import 'package:intl/intl.dart';

//@override
Widget getWorkoutView() {
  // if (currState.currWorkout == null) {
  //   return Text('User is not following a workout plan!');
  // }
  //getCurrWorkout()
  return FutureBuilder(
      future: currState.api.getWorkout("JQfNRY2Bk2eheXWXzsYP"),
      builder: (buildContext, AsyncSnapshot snapshot) {
        if (snapshot.hasError)
          throw snapshot.error;
        else if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          String wday =
              "Tuesday"; //var date = DateTime.now();print(DateFormat('EEEE').format(date));
          int dindex = 0;
          for (var i = 0; i < snapshot.data["days"].length; i++) {
            if (snapshot.data["days"][i]["day"] == wday) {
              print(snapshot.data["days"][i]["day"]);
              dindex = i;
              break;
            }
          }
          print(snapshot.data);
          print(
              'Num exercises: ${snapshot.data["days"][dindex]["routine"].length}');
          return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data["days"][dindex]["day"],
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data["days"][dindex]["routine"].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var currentItem =
                        snapshot.data["days"][dindex]["routine"][index];
                    print('ExerciseId: ${currentItem["exid"].runtimeType}');
                    print('ExerciseId: ${currentItem["exid"]}');
                    return exerciseCard(currentItem);
                  }),
            )
          ]);
        }
      });
}

Widget exerciseCard(Map<String, dynamic> exerciseData) {
  return Container(
    padding: EdgeInsets.all(12),
    // width: 320,
    height: 120,
    child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 4,
        child: FutureBuilder(
          future: currState.api.getExercise(exerciseData["exid"]),
          builder: (buildContext, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              throw snapshot.error;
            } else if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              print(snapshot.data.data());
              String fieldName;
              String fieldTitle;
              if (snapshot.data["category"] == "strength") {
                fieldName = "reps";
                fieldTitle = "Reps";
              } else if (snapshot.data["category"] == "endurance") {
                fieldName = "dur";
                fieldTitle = "Duration";
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    width: 120,
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data["name"],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(snapshot.data["info"],
                              textAlign: TextAlign.center),
                        ]),
                  ),
                  VerticalDivider(thickness: 2, color: Colors.black12),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(fieldTitle,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ListView.builder(
                            itemCount: exerciseData[fieldName].length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String repCount =
                                  exerciseData[fieldName][index].toString();
                              return Text(repCount,
                                  textAlign: TextAlign.center);
                            }),
                      ],
                    ),
                  ),
                  VerticalDivider(thickness: 2, color: Colors.black12),
                  Container(
                    padding: EdgeInsets.all(8),
                    // width: 72,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Difficulty",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          snapshot.data["difficulty"].toString(),
                          textAlign: TextAlign.center,
                          textScaleFactor: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        )),
  );
}

class WorkoutPage extends StatefulWidget {
  WorkoutPage();
  @override
  WorkoutPageState createState() => WorkoutPageState();
}

class WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    // int index = 2;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.background,
        appBar: AppBar(
          // backgroundColor: theme.appBar,
          elevation: 5,
          title: Text("Workout"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EditWorkout();
                      }));
                    },
                    child: Icon(Icons.edit))),
          ],
        ),
        bottomNavigationBar: NavigationBar(2),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(child: getWorkoutView()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return InWorkout();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Start Workout",
                    style: TextStyle(
                        // color: Colors.white.withAlpha(230),
                        fontSize: 20),
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
