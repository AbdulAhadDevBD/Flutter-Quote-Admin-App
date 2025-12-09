import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: Colors.grey[100],
    fontFamily: 'Poppins',
    cardColor: CupertinoColors.systemGrey5,
    

    appBarTheme: AppBarTheme(
      elevation: 3,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 18,
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primary,
      foregroundColor: Colors.white, // icon color
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Poppins',

    cardColor: CupertinoColors.secondaryLabel,

    appBarTheme: AppBarTheme(
      elevation: 3,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 18,
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primary,
      foregroundColor: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
