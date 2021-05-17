import 'package:flutter/material.dart';

class CustomTheme{
  Color primary;
  Color secondary;
  Color nav;
  Color highlight;
  Color text;
  Color background;
  Gradient backgroundGrad;
  Color appBar;
  Color appBarText;
}

CustomTheme darkTheme(){
  var dark = new CustomTheme();
  dark.primary = Colors.black;
  dark.secondary = Colors.black;
  // dark.nav;
  // dark.highlight;
  // dark.text;
  dark.background = Color(0xFF141414);
  dark.appBar = Color(0xFF1D4350);
  dark.appBarText = Colors.white;
  dark.backgroundGrad = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Color(0xFFa43931), Color(0xFF1D4350)]
  );
  return dark;
}