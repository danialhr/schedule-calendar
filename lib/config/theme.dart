import 'package:flutter/material.dart';

import '../constants/colors.dart';

final ThemeData scheduleCalendarTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(backgroundColor: Palette.white),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Palette.blancoWhite,
      fontFamily: 'LemonMilkPro',
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      color: Palette.ashGrey,
      fontSize: 16.0,
      fontFamily: 'LemonMilkPro',
      fontWeight: FontWeight.w300,
    ),
    labelLarge: TextStyle(
      color: Palette.ashGrey,
      fontSize: 14.0,
      fontFamily: 'LemonMilkPro',
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      color: Palette.black,
      fontSize: 12.0,
      fontFamily: 'LemonMilkPro',
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      color: Palette.ashGrey,
      fontSize: 10.0,
      fontFamily: 'LemonMilkPro',
      fontWeight: FontWeight.w300,
    ),
  ),
);
