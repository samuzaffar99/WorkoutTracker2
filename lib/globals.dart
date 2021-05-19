// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_tracker2/api.dart';
import 'dart:async';

import 'package:workout_tracker2/theme.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   clientId:
//       '363391434933-4asstkqhcb75napiu2jekoqcr0bd8nkq.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

class StateData {
  User firebaseUser;
  SharedPreferences prefs;
  var db = FirebaseFirestore.instance;
  bool isLoggedIn = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  DocumentReference userRef;
  DocumentSnapshot userData;
  DocumentReference currWorkoutRef;
  DocumentSnapshot workoutData;
  DocumentSnapshot dietData;
  StateData._privateConstructor();

  Api api = Api();

  static final StateData _instance = StateData._privateConstructor();

  factory StateData() {
    return _instance;
  }
  Future<void> fetchUser() async{
    userRef = db.collection("users").doc(firebaseUser.uid);
    userData = await userRef.get();
  }
  Future<bool> initializeUser() async {
    firebaseUser = await signIn();
    await fetchUser();
    if (userData.exists) {
      print("UserData present on firestore");
      return true;
    } else {
      print("UserData not present on firestore");
      return false;
    }
    // print(userData.data());
    // Save Default Data to local preferences
    // await prefs.setString('id', firebaseUser.uid);
    // await prefs.setString('nickname', firebaseUser.displayName);
    // await prefs.setString('photoUrl', firebaseUser.photoURL);
    // print(UserData.data());
    // Load Data from Cloud to local preferences
    // await prefs.setString('id', UserData.get('id'));
    // await prefs.setString('nickname', UserData["nickname"]);
    // await prefs.setString('photoUrl', UserData[0].data()['photoUrl']);
    // await prefs.setString('aboutMe', UserData[0].data()['aboutMe']);
    // return existsUser;
  }

  Future<User> signIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    return firebaseUser;
  }

  Future<void> signOut() async {
    // await googleSignIn.signOut();
    await googleSignIn.disconnect();
    await firebaseAuth.signOut();
  }

  //Create new user data using firebase uid
  Future<void> createUser(Map userData) async {
    await api.putUser(firebaseUser.uid, userData);
    return;
  }

  Future<void> getCurrWorkout() async {
    String id = userData.get("currWorkout");
    print(id);
    workoutData = await api.getWorkout(id);
    return workoutData;
  }

  Future<void> getCurrDiet() async {
    String id = userData.get("currDiet");
    print(id);
    dietData = await api.getDiet(id);
    return dietData;
  }
}

final StateData currState = StateData();
var theme = darkTheme();
// void func(){
//   var F=ThemeData();
//   F.tabBarTheme;
// }

List<DropdownMenuItem<String>> generateDropdownItems(List<String> ddl) {
  return ddl
      .map((value) => DropdownMenuItem(
    value: value,
    child: Text(value),
  ))
      .toList();
}

double calcBMI(double weight,double height) {
  return (weight*10000)/(height*height);
}