// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:workout_tracker2/ui/setup/ui_setup_complete.dart';
// import 'package:pie_chart/pie_chart.dart';
// import '../others/animated_background.dart';

class PlanDiet extends StatefulWidget {
  @override
  _PlanDietState createState() => _PlanDietState();
}

class _PlanDietState extends State<PlanDiet> {
  bool toggleLactose = false;
  bool toggleSugar = false;
  RangeValues _values = RangeValues(100, 900);
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
                      //   'assets/images/pic3.jpg',
                      // ),
                      Text(
                        'Plan Diet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white.withAlpha(230),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 55),
                  //Insert Pie chart here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Fat",
                        style: TextStyle(
                            color: Colors.white.withAlpha(240),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                            color: Colors.white.withAlpha(240),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      Text(
                        "Protein",
                        style: TextStyle(
                            color: Colors.white.withAlpha(240),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                            color: Colors.white.withAlpha(240),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      Text(
                        "Carbs",
                        style: TextStyle(
                            color: Colors.white.withAlpha(240),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 25,
                      rangeThumbShape: RoundRangeSliderThumbShape(
                          enabledThumbRadius: 18,
                          pressedElevation: 20,
                          elevation: 30),
                      showValueIndicator: ShowValueIndicator.never,
                    ),
                    child: RangeSlider(
                      divisions: 6,
                      values: _values,
                      min: 0,
                      max: 1000,
                      labels: RangeLabels(
                          '${_values.start.round()}', '${_values.end.round()}'),
                      inactiveColor: Colors.white.withAlpha(220),
                      activeColor: Colors.white,
                      onChanged: (RangeValues values) {
                        setState(() {
                          _values = values;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "   Lactose Free",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white.withAlpha(230),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Switch(
                        inactiveTrackColor: Colors.white.withAlpha(230),
                        inactiveThumbColor: Colors.white.withAlpha(230),
                        activeTrackColor: Colors.green[10],
                        activeColor: Colors.green,
                        value: toggleLactose,
                        onChanged: (value) {
                          setState(() {
                            toggleLactose = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "   Sugar Free",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white.withAlpha(230),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Switch(
                        inactiveTrackColor: Colors.white.withAlpha(230),
                        inactiveThumbColor: Colors.white.withAlpha(230),
                        activeTrackColor: Colors.green[10],
                        activeColor: Colors.green,
                        value: toggleSugar,
                        onChanged: (value) {
                          setState(() {
                            toggleSugar = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
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
                                      return SetupComplete();
                                    },
                                  ),
                                );
                              },
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
                      SizedBox(
                        width: 22,
                      ),
                      ButtonTheme(
                        height: 45.0,
                        minWidth: 130.0,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SetupComplete();
                                },
                              ),
                            );
                          },
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
