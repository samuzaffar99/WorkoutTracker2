import 'package:flutter/material.dart';

class EditWorkout extends StatefulWidget {
  EditWorkout();
  @override
  _EditWorkoutState createState() => _EditWorkoutState();
}

Widget editExerciseCard() {
  // User user;
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
                      text: "    Exercise",
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

class _EditWorkoutState extends State<EditWorkout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Edit Workout"),
        elevation:5,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFFa43931), Color(0xFF1D4350)])),
        child: ListView(
          children: [
            Opacity(
              opacity: 0.5,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 5,
                margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 590,
                    width: 275,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          editExerciseCard(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonTheme(
                  height: 45.0,
                  minWidth: 160.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Discard Changes",
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
                ButtonTheme(
                  height: 45.0,
                  minWidth: 160.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save Changes",
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
            )
          ],
        ),
      ),
    ));
  }
}
