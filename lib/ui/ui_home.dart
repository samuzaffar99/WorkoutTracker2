import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:workout_tracker2/ui/ui_explore_exercises.dart';
import 'package:workout_tracker2/ui/workout/ui_choose_new_workout_plan.dart';
import 'package:workout_tracker2/ui/ui_navbar.dart';
import 'package:workout_tracker2/ui/workout/ui_workout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.background,
        appBar: AppBar(
          // backgroundColor: theme.appBar,
          elevation: 5,
          title: Text('Home'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                "Hey ${currState.userData["nickname"]}! \nExplore your Daily Routines",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  // color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    height: 45.0,
                    minWidth: 275.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ExploreExercises();
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Explore Exercises",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    height: 45.0,
                    minWidth: 275.0,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ChooseNewWorkoutPlan();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Choose New Workout Plan",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                color: Colors.blueAccent,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30),
                // ),
                elevation: 10,
                margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                  // height: 400,
                  // width: 275,
                  child: Column(
                    children: [
                      Text("Today's Exercises",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: 12),
                      DefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                        child: Container(
                          height: 240,
                          width: double.maxFinite,
                          child: getWorkoutView(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(0),
      ),
    );
  }
}
