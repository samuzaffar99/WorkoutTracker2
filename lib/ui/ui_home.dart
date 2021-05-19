import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:workout_tracker2/ui/ui_explore_exercises.dart';
import 'package:workout_tracker2/ui/workout/ui_choose_new_workout_plan.dart';
import 'package:workout_tracker2/ui/ui_exercise_results.dart';
import 'package:workout_tracker2/ui/ui_navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          backgroundColor: theme.appBar,
          elevation: 5,
          title: Text('Home', style: TextStyle(color: theme.appBarText)),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Hey ${currState.userData["nickname"]}! \nExplore your Daily Routines",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Choose New Workout Plan",
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
              Card(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30),
                // ),
                elevation: 5,
                margin: EdgeInsets.fromLTRB(16, 32, 16, 32),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  // height: 400,
                  // width: 275,
                  child: Column(
                    children: [
                      Text("Today's Exercises\n",
                          style: TextStyle(fontSize: 36)),
                      DefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                        child: Container(
                          height: 360,
                          child: ListView(children: [
                            Text("Deadlift 10-8-6"),
                            Text("Deadlift 10-8-6"),
                            Text("Squats   12-8"),
                            Text("Curls   25-20"),
                          ]),
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
