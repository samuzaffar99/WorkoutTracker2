import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'ui_workout.dart';

class WorkoutSummary extends StatelessWidget {
  WorkoutSummary();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.appBar,
        elevation: 5,
        title: Text("Summary"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: getWorkoutView(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
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
                            Navigator.pop(context);
                            Navigator.pushNamed(context, 'Home');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next",
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
            )
          ],
        ),
      ),
    ));
  }
}
