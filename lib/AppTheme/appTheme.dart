import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.red,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black
      ),
    ),
    primaryColor: Colors.red,
    primaryColorLight: Colors.redAccent,
    bottomAppBarColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
              fontSize: 8.8, fontWeight: FontWeight.bold, color: Colors.red),
      indicator: null,
      labelColor: Colors.red,
      unselectedLabelColor: Colors.black,
    ),
    cardColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black,
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    cursorColor: Colors.black,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF272928),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white
      ),
    ),
    primaryColor: Colors.white54,
    primaryColorLight: Colors.redAccent,
    bottomAppBarColor: Colors.black,
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
              fontSize: 8.8, fontWeight: FontWeight.bold, color: Colors.red),
      indicator: null,
      labelColor: Colors.red,
      unselectedLabelColor: Colors.white,
    ),
    dividerColor: Colors.grey[800],
    cardColor: Colors.black,
    dialogBackgroundColor: Colors.grey[800],
    unselectedWidgetColor: Colors.white,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    cursorColor: Colors.white,
  );
}