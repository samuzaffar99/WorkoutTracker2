import 'package:flutter/material.dart';

// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'ui_workout.dart';

class WorkoutSummary extends StatelessWidget {
  WorkoutSummary();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // backgroundColor: theme.background,
      appBar: AppBar(
        // backgroundColor: theme.appBar,
        elevation: 5,
        title: Text("Summary"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Expanded(child: getWorkoutView()),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "Home", (Route<dynamic> route) => false);
                },
                child: Text(
                  "Finish",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
