import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker2/admin.dart';

import 'package:workout_tracker2/ui/ui_login.dart';
import 'package:workout_tracker2/ui/ui_home.dart';
import 'package:workout_tracker2/ui/ui_diet.dart';
import 'package:workout_tracker2/ui/ui_settings.dart';
import 'package:workout_tracker2/ui/ui_setup.dart';
import 'package:workout_tracker2/ui/ui_workout.dart';
import 'package:workout_tracker2/ui/ui_log.dart';
import 'package:workout_tracker2/ui/ui_profile.dart';


// import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // SharedPreferences.Editor.clear();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: LoginPage(),
      initialRoute: 'Login',
      routes: {
        'Login': (context) => LoginPage(),
        'Home': (context) => HomePage(),
        'Diet': (context) => DietPage(),
        'Workout': (context) => WorkoutPage(),
        'Log': (context) => LogPage(),
        'Profile': (context) => ProfilePage(),
        'Admin': (context) => AdminPage(),
        'Settings': (context) => SettingsPage(),
        'Setup': (context) => SetupPage(),
      },
    );
  }
}