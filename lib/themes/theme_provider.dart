import 'package:flutter/material.dart';

class ThemeProvider {
  static String fontFamily = "Urbanist";
  static ThemeData get light => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.transparent),
      useMaterial3: false,
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 19),
          bodyLarge: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          headlineSmall: TextStyle(fontWeight: FontWeight.w700)),
      fontFamily: fontFamily);
}
