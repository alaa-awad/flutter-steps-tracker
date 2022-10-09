import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: primaryColorDark, secondary: secondaryColorDark),
  scaffoldBackgroundColor: backgroundDark,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: surfaceDark,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: backgroundDark,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: textColorDark,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: onPrimaryColorDark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: primaryColorDark,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: backgroundDark,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: textColorDark,
      ),
      subtitle1: TextStyle(
        fontSize: 15.0,
        color: textColorDark,
        height: 1.4,
      ),
    subtitle2: TextStyle(
      fontSize: 15.0,
      // fontWeight: FontWeight.w600,
      color: textColorLight,
      height: 1.4,
    ),
  ),
  fontFamily: 'Jannah',
  cardColor: surfaceDark,
  iconTheme: IconThemeData(
    color: onPrimaryColorDark,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: onPrimaryColorDark,
    textTheme: ButtonTextTheme.primary,
  ),
);

final ThemeData lightTheme = ThemeData(
  //primarySwatch: defaultColor,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: primaryColorLight, secondary: secondaryColorLight),
  scaffoldBackgroundColor: backgroundLight,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: backgroundLight,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: backgroundLight,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: textColorLight,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: onPrimaryColorLight,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: primaryColorLight,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: backgroundLight,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: textColorLight,
    ),
    subtitle1: TextStyle(
      fontSize: 15.0,
      // fontWeight: FontWeight.w600,
      color: textColorLight,
      height: 1.4,
    ),
    subtitle2: TextStyle(
      fontSize: 15.0,
      // fontWeight: FontWeight.w600,
      color: textColorDark,
      height: 1.4,
    ),
  ),
  fontFamily: 'Jannah',
  cardColor: surfaceLight,
  iconTheme: IconThemeData(
    color: onPrimaryColorLight,
  ),
  buttonColor: onPrimaryColorLight,
);
