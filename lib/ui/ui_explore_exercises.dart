// import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker2/globals.dart';
import 'package:workout_tracker2/ui/ui_exercise_results.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

class ExploreExercises extends StatefulWidget {
  @override
  _ExploreExercisesState createState() => _ExploreExercisesState();
}

class _ExploreExercisesState extends State<ExploreExercises> {
  bool toggleEndurance = false;
  bool toggleStrength = false;
  String searchString = "";
  List<String> category = [
    "Biceps",
    "Triceps",
    "Chest",
    "Abdominals",
    "Glutes",
    "Hamstrings",
    "Quadriceps"
  ];
  List<bool> categoryToggle = List.filled(7, false);
  List<String> sortParams = ["Name", "Difficulty"];
  bool toggleAsc = true;
  String currParam = "Name";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.background,
        appBar: AppBar(
          // backgroundColor: theme.appBar,
          elevation: 5,
          title: Text("Explore"),
          centerTitle: true,
        ),
        body: Container(
          child: Card(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24),
                Container(
                  height: 80,
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: double.maxFinite,
                        width: 240,
                        child: TextField(
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Search",
                          ),
                          // controller: searchController,
                          onChanged: (value) => searchString = value,
                        ),
                      ),
                      OutlinedButton.icon(
                          label: Text("Search"),
                          icon: Icon(Icons.search),
                          // style: OutlinedButton.styleFrom(primary: Colors.deepOrange),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ExerciseResults();
                              },
                            ));
                          }),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text("Target Muscles"),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Wrap(
                      children: List<Widget>.generate(
                        category.length,
                        (int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new FilterChip(
                                selected: categoryToggle[index],
                                selectedColor: Colors.deepOrange,
                                padding: EdgeInsets.fromLTRB(4, 12, 4, 12),
                                label: Text(category[index]),
                                labelStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                onSelected: (bool selected) {
                                  setState(() {
                                    categoryToggle[index] =
                                        !categoryToggle[index];
                                  });
                                }),
                          );
                        },
                      ),
                    )
                  ],
                )),
                Container(
                  width: 240,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Strength", style: TextStyle(fontSize: 18)),
                          Switch(
                            value: toggleStrength,
                            onChanged: (value) {
                              setState(() {
                                toggleStrength = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Endurance", style: TextStyle(fontSize: 18)),
                          Switch(
                            value: toggleEndurance,
                            onChanged: (value) {
                              setState(() {
                                toggleEndurance = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 30, left: 30),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Sort By",
                            ),
                            items: generateDropdownItems(sortParams),
                            value: currParam,
                            onChanged: (val) {
                              setState(
                                () {
                                  currParam = val.toString();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ascending", style: TextStyle(fontSize: 18)),
                    Switch(
                      value: toggleAsc,
                      onChanged: (value) {
                        setState(() {
                          toggleAsc = value;
                        });
                      },
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
