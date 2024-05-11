import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xfff6f1f1),
    primary: Color(0xff19a7ce),
    secondary: Color(0xffafd3e2),
    inversePrimary: Color(0xff141e61),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Color(0xff146C94),
        displayColor: Colors.black,
      ),
);
