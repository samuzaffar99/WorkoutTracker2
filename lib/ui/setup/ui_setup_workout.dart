import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:workout_tracker2/ui/setup/ui_setup_plan_diet.dart';
// import '../others/animated_background.dart';

class ChoosePlan extends StatefulWidget {
  @override
  _ChoosePlanState createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  List<bool> isSelected = List.generate(7, (_) => false);
  List<bool> isSelected2 = List.generate(3, (_) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.background,
        body: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(child: Center()),
              Column(
                children: [
                  Stack(
                    alignment: Alignment(0,1.2),
                    children: [
                      // Image.asset(
                      //   'assets/images/pic1.png',
                      // ),
                      Text(
                        'Select a Training Plan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white.withAlpha(230),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: 10,
                        child: ToggleButtons(
                          children: [
                            MaterialButton(
                              child: Text("M",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                  )),
                              onPressed: null,
                            ),
                            MaterialButton(
                              child: Text("T",
                                  style:
                                      TextStyle(color: Colors.white.withAlpha(200))),
                              onPressed: null,
                            ),
                            MaterialButton(
                              child: Text("W",
                                  style:
                                      TextStyle(color: Colors.white.withAlpha(200))),
                              onPressed: null,
                            ),
                            MaterialButton(
                              child: Text("T",
                                  style:
                                      TextStyle(color: Colors.white.withAlpha(200))),
                              onPressed: null,
                            ),
                            MaterialButton(
                              child: Text("F",
                                  style:
                                      TextStyle(color: Colors.white.withAlpha(200))),
                              onPressed: null,
                            ),
                            MaterialButton(
                              child: Text("S",
                                  style:
                                      TextStyle(color: Colors.white.withAlpha(200))),
                              onPressed: null,
                            ),
                            MaterialButton(
                              child: Text("S",
                                  style:
                                      TextStyle(color: Colors.white.withAlpha(200))),
                              onPressed: null,
                            ),
                          ],
                          selectedBorderColor: Colors.white.withAlpha(200),
                          borderColor: Colors.white.withAlpha(200),
                          color: Colors.white.withAlpha(200),
                          selectedColor: Colors.white.withAlpha(200),
                          fillColor: Colors.white.withAlpha(150),
                          isSelected: isSelected,
                          onPressed: (int index) {
                            setState(
                              () {
                                isSelected[index] = !isSelected[index];
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 25),
                      RotatedBox(
                        quarterTurns: 1,
                        child: ToggleButtons(
                          selectedBorderColor: Colors.white.withAlpha(200),
                          borderRadius: BorderRadius.circular(10),
                          borderColor: Colors.white.withAlpha(180),
                          fillColor: Colors.white.withAlpha(150),
                          children: [
                            RotatedBox(
                              quarterTurns: 3,
                              child: MaterialButton(
                                child: Text("Home Exercise",
                                    style: TextStyle(
                                        color: Colors.white.withAlpha(200))),
                                onPressed: null,
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 3,
                              child: MaterialButton(
                                child: Text("Power Lifting",
                                    style: TextStyle(
                                        color: Colors.white.withAlpha(200))),
                                onPressed: null,
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 3,
                              child: MaterialButton(
                                child: Text(
                                  "Body Building",
                                  style:
                                      TextStyle(color: Colors.white.withAlpha(200)),
                                ),
                                onPressed: null,
                              ),
                            ),
                          ],
                          isSelected: isSelected2,
                          onPressed: (int index) {
                            setState(
                              () {
                                for (int indexBtn = 0;
                                    indexBtn < isSelected2.length;
                                    indexBtn++) {
                                  if (indexBtn == index) {
                                    isSelected2[indexBtn] = true;
                                  } else {
                                    isSelected2[indexBtn] = false;
                                  }
                                }
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            height: 45.0,
                            minWidth: 130.0,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PlanDiet();
                                    },
                                  ),
                                );
                              },
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(30.0),
                              // ),
                              // color: Colors.transparent,
                              // textColor: Colors.white.withAlpha(200),
                              // borderSide: BorderSide(
                              //     color: Colors.white.withAlpha(200), width: 1.25),
                              // highlightedBorderColor: Colors.white.withAlpha(200),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Skip",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withAlpha(230),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 22),
                      ButtonTheme(
                        height: 45.0,
                        minWidth: 130.0,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PlanDiet();
                                },
                              ),
                            );
                          },
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(30.0),
                          // ),
                          // color: Colors.transparent,
                          // textColor: Colors.white.withAlpha(200),
                          // borderSide: BorderSide(
                          //     color: Colors.white.withAlpha(200), width: 1.25),
                          // highlightedBorderColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white.withAlpha(230),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
