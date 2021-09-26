import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../admin.dart';
import 'ui_diet.dart';
import 'ui_home.dart';
import 'ui_profile.dart';
import 'ui_settings.dart';
import 'workout/ui_workout.dart';

class NavigationBar extends StatefulWidget {
  final int index;
  NavigationBar(this.index);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  List routes = ["Home", "Diet", "Workout", "Log", "Profile"];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      onTap: (int i) {
        setState(
          () {
            if (widget.index == i) {
              Navigator.popUntil(context, ModalRoute.withName(routes[i]));
              return;
            } else {
              // widget.index = i;
              Navigator.pushReplacementNamed(context, routes[i]);
            }
          },
        );
      },
      // backgroundColor: Colors.red,
      selectedItemColor: Colors.black,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.black54,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_dining),
          label: 'Diet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Workout',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          label: 'Log',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        )
      ],
    );
  }
}

class NavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavController());
  }
}

class NavController extends GetxController {
  int currIndex = 0;
  final List routeList = [
    '/home',
    '/diet',
    '/workout',
    '/log',
    // '/settings',
    '/profile'
  ];

  void changeTabIndex(int index) {
    print('prevIndex = $currIndex click index=$index');
    if (index == currIndex) {
      print("popping");
      Get.back(result: routeList[index], closeOverlays: true, id: 1);
    } else {
      currIndex = index;
      Get.offAllNamed(routeList[index], id: 1);
    }
    update();
  }

  final Map getPages = {
    // '/': {'page': () => HomePage()},
    '/home': {'page': () => HomePage()},
    '/workout': {'page': () => WorkoutPage()},
    '/diet': {'page': () => DietPage()},
    '/settings': {'page': () => SettingsPage()},
    '/profile': {'page': () => ProfilePage()},
    '/admin': {'page': () => AdminPage()},
  };

  Route? onGenerateRoute(RouteSettings settings) {
    print("route name: " + settings.name!);
    if (settings.name != '/') {
      return GetPageRoute(
        settings: settings,
        page: getPages[settings.name]['page'],
        // binding: HomeBinding(),
      );
    } else {
      return null;
    }
  }
}

// GetView<NavController>
class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  static NavController get to => Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
      init: NavController(),
      builder: (navController) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Navigator(
              key: Get.nestedKey(1),
              initialRoute: '/home',
              onGenerateRoute: navController.onGenerateRoute,
            ),
            bottomNavigationBar: NavBar(),
          ),
        );
      },
    );
  }
}

// class ConvexNavBar extends StatelessWidget {
//   const ConvexNavBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<NavController>(builder: (navController) {
//       return ConvexAppBar(
//           items: const [
//             TabItem(icon: Icons.home, title: 'Home'),
//             TabItem(icon: Icons.search, title: 'Search'),
//             TabItem(icon: Icons.people, title: 'Profile'),
//             TabItem(icon: Icons.settings, title: 'Settings'),
//           ],
//           initialActiveIndex: navController.currIndex,
//           onTap: (int i) {
//             navController.changeTabIndex(i);
//           });
//     });
//   }
// }

class NavBar extends StatelessWidget {
  final NavController controller = Get.find<NavController>();
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: controller.currIndex,
      onTap: (int i) {
        controller.changeTabIndex(i);
      },
      // backgroundColor: Colors.red,
      selectedItemColor: Colors.black,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.black54,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_dining),
          label: 'Diet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Workout',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          label: 'Log',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        )
      ],
    );
  }
}
