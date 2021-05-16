import 'package:flutter/material.dart';

class CustomTheme{
  Color primary;
  Color secondary;
  Color nav;
  Color highlight;
  Color text;
  Color background;
  Color appbar;
}
void func(){
  var dark = new CustomTheme();
  dark.primary = Colors.black;
  dark.secondary = Colors.black;
  // dark.nav;
  // dark.highlight;
  // dark.text;
  // dark.background;
  // dark.appbar;
}

var currTheme = CustomTheme();

Color appBarColor = Color(0xFF1D4350);
Color backGroundColor = Color(0xFF141414);
Color titleTextColor = Colors.white;

Gradient backGroundGrad = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [Color(0xFFa43931), Color(0xFF1D4350)]
);