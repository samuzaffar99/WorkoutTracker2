import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_tracker2/ui/setup/ui_setup.dart';
import 'package:workout_tracker2/ui/ui_login.dart';

import 'services/api.dart';
import 'services/login_api.dart';
import 'ui/ui_navbar.dart';

Future<void> main() async {
  await initializeApp();
  runApp(const WorkoutApp());
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(Api());
  Get.put(Session());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Workout Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/root',
          page: () => const RootPage(),
          binding: NavBinding(),
        ),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/setup', page: () => SetupPage()),
        // GetPage(name: '/home', page: () => HomePage()),
        // GetPage(name: '/diet', page: () => DietPage()),
        // GetPage(name: '/workout', page: () => WorkoutPage()),
        // GetPage(name: '/log', page: () => LogPage()),
        // GetPage(name: '/profile', page: () => ProfilePage()),
        // GetPage(name: '/admin', page: () => AdminPage()),
        // GetPage(name: '/settings', page: () => SettingsPage()),
      ],
      // routes: {
      //   'Login': (context) => LoginPage(),
      //   'Home': (context) => HomePage(),
      //   'Diet': (context) => DietPage(),
      //   'Workout': (context) => WorkoutPage(),
      //   'Log': (context) => LogPage(),
      //   'Profile': (context) => ProfilePage(),
      //   'Admin': (context) => AdminPage(),
      //   'Settings': (context) => SettingsPage(),
      //   'Setup': (context) => SetupPage(),
      // },
    );
  }
}
