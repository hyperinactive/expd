import 'package:flutter/material.dart';

class AndroidThemeData {
  final themeData = ThemeData(
    // primarySwatch -> based on a singular color but sets up different shades of it
    // fontFamily from the pubspec file
    primarySwatch: Colors.pink,
    accentColor: Colors.amber,
    errorColor: Colors.red,
    fontFamily: 'Quicksand',
    textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        )),
    appBarTheme: AppBarTheme(
        // copying the light theme of ThemeData's default but replace the title with our font
        textTheme: ThemeData.light().textTheme.copyWith(
              // headline6 == title
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white),
            )),
  );
}
