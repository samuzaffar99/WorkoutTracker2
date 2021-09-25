import 'package:flutter/material.dart';

class CustomTheme {
  Color primary;
  Color secondary;
  Color nav;
  // Color highlight;
  Color text;
  Color background;
  Gradient backgroundGrad;
  Color appBar;
  Color appBarText;

  CustomTheme.darkTheme()
      : primary = Colors.black,
        secondary = Colors.black,
        nav = Colors.black,
        text = Colors.white,
        background = Color(0xFF141414),
        appBar = Color(0xFF1D4350),
        appBarText = Colors.white,
        backgroundGrad = LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFFa43931), Color(0xFF1D4350)],
        );
}

class StyledElevatedButton extends StatelessWidget {
  StyledElevatedButton(this.color, this.text, this.onPressed);
  final Color color;
  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: color),
            onPressed: onPressed(),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}

class StyledOutlinedButton extends StatelessWidget {
  StyledOutlinedButton(this.color, this.text, this.onPressed);
  final Color color;
  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onPressed(),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}

class StyledAppBar extends StatelessWidget {
  StyledAppBar(this.color, this.text);
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
    );
  }
}
