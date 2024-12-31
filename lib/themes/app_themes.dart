import 'package:flutter/material.dart';

class CustomButtonTheme {
  Color labelColor;
  Color iconColor;
  Color buttonColor;

  CustomButtonTheme({
    required this.labelColor,
    required this.iconColor,
    required this.buttonColor,
  });
}

class CustomButtonThemes {
  static final blueTheme = CustomButtonTheme(
    labelColor: Colors.blue.shade800,
    iconColor: const Color.fromARGB(255, 255, 255, 255),
    buttonColor: Colors.blueAccent,
  );

  static final greenTheme = CustomButtonTheme(
    labelColor: Colors.green,
    iconColor: Colors.green,
    buttonColor: Colors.greenAccent,
  );

  static final redTheme = CustomButtonTheme(
    labelColor: Colors.red,
    iconColor: Colors.red,
    buttonColor: Colors.redAccent,
  );

  static final yellowTheme = CustomButtonTheme(
    labelColor: Colors.yellow,
    iconColor: Colors.yellow,
    buttonColor: Colors.yellowAccent,
  );

  static final purpleTheme = CustomButtonTheme(
    labelColor: Colors.purple,
    iconColor: Colors.purple,
    buttonColor: Colors.purpleAccent,
  );

  static final orangeTheme = CustomButtonTheme(
    labelColor: Colors.orange,
    iconColor: Colors.orange,
    buttonColor: Colors.orangeAccent,
  );

  static final pinkTheme = CustomButtonTheme(
    labelColor: Colors.pink,
    iconColor: Colors.pink,
    buttonColor: Colors.pinkAccent,
  );

  static final tealTheme = CustomButtonTheme(
    labelColor: Colors.teal,
    iconColor: Colors.teal,
    buttonColor: Colors.tealAccent,
  );

  static final cyanTheme = CustomButtonTheme(
    labelColor: Colors.cyan,
    iconColor: Colors.cyan,
    buttonColor: Colors.cyanAccent,
  );

  static final limeTheme = CustomButtonTheme(
    labelColor: Colors.lime,
    iconColor: Colors.lime,
    buttonColor: Colors.limeAccent,
  );

  static final customThemes = [
    blueTheme,
    greenTheme,
    redTheme,
    yellowTheme,
    purpleTheme,
    orangeTheme,
    pinkTheme,
    tealTheme,
    cyanTheme,
    limeTheme,
  ];
}
