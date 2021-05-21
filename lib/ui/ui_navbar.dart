import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  int index;
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
              widget.index = i;
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
