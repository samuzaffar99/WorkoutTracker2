import 'package:flutter/material.dart';
import 'package:workout_tracker2/ui/ui_navbar.dart';
import 'package:workout_tracker2/ui/ui_edit_workout.dart';
import 'package:workout_tracker2/ui/ui_in_workout.dart';
import 'package:workout_tracker2/globals.dart';

// import 'package:intl/intl.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

//@override
Widget getWorkoutView() {
  // if (widget.user.currWorkout == null) {
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
                    return Card(
                        color: Colors.grey[300],
                        elevation: 4,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('ExerciseId : ${currentItem["exid"]}'),
                              FutureBuilder(
                                  future: currState.api
                                      .getExercise(currentItem["exid"]),
                                  builder:
                                      (buildContext, AsyncSnapshot snapshot) {
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
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: [
                                          Container(
                                            width: 80,
                                            child: Column(
                                              children: [
                                                Text(snapshot.data["name"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                if (snapshot.data["info"] !=
                                                    null)
                                                  Text(snapshot.data["info"])
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Builder(builder: (context) {
                                            if (snapshot.data["category"] ==
                                                "strength") {
                                              return Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          left: BorderSide(
                                                              width: 5.0,
                                                              color:
                                                                  Colors.white),
                                                          right: BorderSide(
                                                              width: 5.0,
                                                              color: Colors
                                                                  .white))),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("Reps",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      ListView.builder(
                                                          itemCount:
                                                              currentItem[
                                                                      "reps"]
                                                                  .length,
                                                          shrinkWrap: true,
                                                          itemBuilder: (context,
                                                              index2) {
                                                            var currentItem2 =
                                                                currentItem[
                                                                        "reps"]
                                                                    [index2];
                                                            return new Center(
                                                                child: Text(
                                                                    currentItem2
                                                                        .toString()));
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else if (snapshot
                                                    .data["category"] ==
                                                "endurance") {
                                              return Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          left: BorderSide(
                                                              width: 5.0,
                                                              color:
                                                                  Colors.white),
                                                          right: BorderSide(
                                                              width: 5.0,
                                                              color: Colors
                                                                  .white))),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("Duration",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      ListView.builder(
                                                          itemCount:
                                                              currentItem["dur"]
                                                                  .length,
                                                          shrinkWrap: true,
                                                          itemBuilder: (context,
                                                              index2) {
                                                            var currentItem2 =
                                                                currentItem[
                                                                        "dur"]
                                                                    [index2];
                                                            return new Center(
                                                                child: Text(
                                                                    currentItem2
                                                                        .toString()));
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                            return Text(
                                                "Invalid Exercise Category!");
                                          }),
                                          Spacer(),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                new Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text("Difficulty",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Text(
                                                  "${snapshot.data["difficulty"]}",
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style
                                                      .apply(
                                                          fontSizeFactor: 2.0),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                      );
                                    }
                                  }),
                            ]));
                  }),
            )
          ]);
        }
      });
}

Widget exerciseCard() {
  return Container(
    height: 120,
    width: 349,
    child: Card(
      color: Colors.grey[300],
      elevation: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                      text: "    Exercisename",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ]),
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: "    Reps\n",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: "      1\n",
                      ),
                      TextSpan(
                        text: "      1\n",
                      ),
                      TextSpan(
                        text: "      1\n",
                      ),
                    ],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    )),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Difficulty\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                        text: "10.0\n",
                      ),
                    ],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    )),
              )
            ],
          ),
        ],
      ),
    ),
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
        backgroundColor: Color(0xFF141414),
        appBar: AppBar(
          backgroundColor: Color(0xFF1D4350),
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
        bottomNavigationBar:  NavigationBar(2),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: getWorkoutView(),
              ),
              // Opacity(
              //   opacity: 0.5,
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30)
              //     ),
              //     elevation: 5,
              //     margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
              //     child: Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Container(
              //         height: 400,
              //         width: 275,
              //         child: SingleChildScrollView(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               //get number of exercises for this person and
              //               //iterate each using a for loop
              //               //get respective data according to the iteration number/id
              //               exerciseCard(),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      height: 45.0,
                      minWidth: 160.0,
                      child: OutlinedButton(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Start Workout",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withAlpha(230),
                                shadows: <Shadow>[
                                  Shadow(
                                      offset: Offset(1.5, 1.5),
                                      blurRadius: 5.0,
                                      color: Color.fromARGB(255, 0, 0, 0))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
