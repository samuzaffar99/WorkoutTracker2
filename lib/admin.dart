// import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:workout_tracker2/globals.dart';

class AdminPage extends StatefulWidget {
  @override
  AdminPageState createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final diffController = TextEditingController();
  final descController = TextEditingController();
  final targetController = TextEditingController();
  final jsonController = TextEditingController();
  final jsonListController = TextEditingController();
  void exerciseMenu() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Add Exercise',
              style: TextStyle(fontSize: 23),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Exercise Name'),
                  SizedBox(height: 5),
                  TextFormField(controller: nameController),
                  SizedBox(height: 10),
                  Text('Difficulty'),
                  SizedBox(height: 5),
                  TextFormField(controller: diffController),
                  SizedBox(height: 10),
                  Text('Description'),
                  SizedBox(height: 5),
                  TextFormField(controller: descController),
                  SizedBox(height: 10),
                  Text('Target'),
                  SizedBox(height: 5),
                  TextFormField(controller: targetController),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Add to Firestore'),
                    onPressed: () async {
                      Map<String, dynamic> exercise = {
                        "Description": descController.text,
                        "Name": nameController.text,
                        "Difficulty": double.parse(diffController.text),
                        "Target": targetController.text.split(",")
                      };

                      print(exercise);
                      var response = await currState.api.postExercise(exercise);
                      print(response);
                      var data = await currState.api.getDocument(response);
                      print(data.data());
                      Navigator.of(context).pop();
                    },
                  ),
                  Text('JSON'),
                  SizedBox(height: 5),
                  TextFormField(controller: jsonController),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Parse Json and Add to Firestore'),
                    onPressed: () async {
                      Map<String, dynamic> exercise =
                          json.decode(jsonController.text);
                      print(exercise);
                      var response = await currState.api.postExercise(exercise);
                      print(response);
                      var data = await currState.api.getDocument(response);
                      print(data.data());
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void addToFirestore(String collectionName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Add Exercise',
              style: TextStyle(fontSize: 23),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Add JSON Data to $collectionName'),
                  SizedBox(height: 5),
                  TextFormField(controller: jsonController),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Parse Json and Add to Firestore'),
                    onPressed: () async {
                      Map<String, dynamic> jsonData =
                          json.decode(jsonController.text);
                      print(jsonData);
                      var response;
                      if (collectionName == "Workout") {
                        response = await currState.api.postWorkout(jsonData);
                      } else if (collectionName == "Diet") {
                        response = await currState.api.postDiet(jsonData);
                      }
                      // else if(collection=="User") {
                      //   response = await currState.api.postUser(jsonData);
                      // }
                      else if (collectionName == "Food") {
                        response = await currState.api.postFood(jsonData);
                      } else if (collectionName == "Exercise") {
                        response = await currState.api.postExercise(jsonData);
                      } else {
                        print("Invalid Collection!");
                      }
                      print(response);
                      var data = await currState.api.getDocument(response);
                      print(data.data());
                      Navigator.of(context).pop();
                    },
                  ),
                  Text('Add JSON Data to $collectionName'),
                  SizedBox(height: 5),
                  TextFormField(controller: jsonListController),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Add Json Array to Firestore'),
                    onPressed: () async {
                      List jsonArray = json.decode(jsonListController.text);
                      print(jsonArray);
                      var response;
                      var data;
                      jsonArray.forEach((map) async {
                        map.remove("_id");
                        print(map);
                        if (collectionName == "Workout") {
                          response = await currState.api.postWorkout(map);
                        } else if (collectionName == "Diet") {
                          response = await currState.api.postDiet(map);
                        }
                        // else if(collection=="User") {
                        //   response = await currState.api.postUser(map);
                        // }
                        else if (collectionName == "Food") {
                          response = await currState.api.postFood(map);
                        } else if (collectionName == "Exercise") {
                          response = await currState.api.postExercise(map);
                          print(response);
                        } else {
                          print("Invalid Collection!");
                          return;
                        }
                        print(response);
                        data = await currState.api.getDocument(response);
                        print(data.data());
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Admin Panel",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlinedButton(
                  child: Text("Add Exercise"),
                  onPressed: () {
                    addToFirestore("Exercise");
                  }),
              OutlinedButton(
                  child: Text("Add Food"),
                  onPressed: () {
                    addToFirestore("Food");
                  }),
              OutlinedButton(
                  child: Text("Add Diet"),
                  onPressed: () {
                    addToFirestore("Diet");
                  }),
              OutlinedButton(
                  child: Text("Add Workout"),
                  onPressed: () {
                    addToFirestore("Workout");
                  })
            ],
          ),
        ));
  }
}
