import 'package:flutter/material.dart';
import 'package:workout_tracker2/theme.dart';

final CustomTheme theme = CustomTheme.darkTheme();

List<DropdownMenuItem<String>> generateDropdownItems(List<String> ddl) {
  return ddl
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}

double calcBMI(double weight, double height) {
  return (weight * 10000) / (height * height);
}
