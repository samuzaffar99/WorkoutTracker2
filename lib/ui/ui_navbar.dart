import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  int index;
  NavigationBar(this.index);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      onTap: (int i) {
        setState(
          () {
            if (widget.index == i) {
              //do nothing
              return;
            } else
              widget.index = i;
            if (widget.index == 0) {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'Home');
            } else if (widget.index == 1) {
              Navigator.pop(context);
              Navigator.pushNamed(context, "Diet");
            } else if (widget.index == 2) {
              Navigator.pop(context);
              Navigator.pushNamed(context, "Workout");
            } else if (widget.index == 3) {
              Navigator.pop(context);
              Navigator.pushNamed(context, "Log");
            } else if (widget.index == 4) {
              Navigator.pop(context);
              Navigator.pushNamed(context, "Profile");
            }
          },
        );
      },
      fixedColor: Colors.black,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.black,
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
