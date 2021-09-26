import 'package:flutter/material.dart';
import 'package:workout_tracker2/stop_watch.dart';
import 'package:workout_tracker2/ui/workout/ui_workout.dart';
import 'package:workout_tracker2/ui/workout/ui_workout_summary.dart';

class InWorkout extends StatefulWidget {
  InWorkout();

  @override
  _InWorkoutState createState() => _InWorkoutState();
}

class _InWorkoutState extends State<InWorkout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.background,
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlutterStopWatch(),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              Expanded(child: getWorkoutView()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () {
                        // Navigator.popUntil(context,
                        //     ModalRoute.withName('/ui_workout_summary'));
                        // return WorkoutSummary();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WorkoutSummary();
                            },
                          ),
                        );
                      },
                      // textColor: Colors.white,
                      // borderSide: BorderSide(
                      //     color: Colors.white.withAlpha(200), width: 1.25),
                      // highlightedBorderColor: Colors.white,
                      child: Text(
                        "End Workout",
                        style: TextStyle(fontSize: 20),
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
