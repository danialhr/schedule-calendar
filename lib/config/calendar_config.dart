import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/constants.dart';

// Consists of [TextStyle] and [BoxDecoration] that matches the design

class CalendarConfig {
  final TextTheme textTheme;

  CalendarConfig(this.textTheme);

  // Decoration
  Decoration get _rangeDecoration => const BoxDecoration(
        color: Palette.matTurquoise,
        shape: BoxShape.circle,
      );

  // TextStyle
  TextStyle get _defaultStyle => const TextStyle();

  TextStyle get _titleStyle =>
      textTheme.bodyLarge?.copyWith(
        fontSize: 11.0,
        fontWeight: FontWeight.w300,
      ) ??
      _defaultStyle;

  TextStyle get _weekdayStyle =>
      textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ) ??
      _defaultStyle;

  TextStyle get _weekendStyle =>
      textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ) ??
      _defaultStyle;

  TextStyle get _disabledStyle =>
      textTheme.labelLarge?.copyWith(
        color: Palette.mistyGrey,
        fontWeight: FontWeight.w300,
        decoration: TextDecoration.lineThrough,
        decorationThickness: 1.0,
        decorationColor: Palette.mistyGrey,
      ) ??
      _defaultStyle;

  TextStyle get _daysStyle =>
      textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w300,
      ) ??
      _defaultStyle;

  TextStyle get _todayStyle =>
      textTheme.labelLarge?.copyWith(
        color: Palette.matRed,
        fontWeight: FontWeight.w300,
      ) ??
      _defaultStyle;

  TextStyle get _rangeStyle =>
      textTheme.labelLarge?.copyWith(
        color: Palette.black,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.2,
      ) ??
      _defaultStyle;

  DaysOfWeekStyle get daysOfWeekStyle => DaysOfWeekStyle(
        weekdayStyle: _weekdayStyle,
        weekendStyle: _weekendStyle,
        dowTextFormatter: (date, _) => DateFormat('E').format(date)[0],
      );

  HeaderStyle get headerStyle => HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        headerMargin: const EdgeInsets.only(
          top: 20.0,
          bottom: 36.0,
        ),
        titleTextStyle: _titleStyle,
        leftChevronMargin: const EdgeInsets.only(left: 80.0),
        rightChevronMargin: const EdgeInsets.only(right: 80.0),
        leftChevronIcon: const Icon(
          Icons.chevron_left,
          color: Palette.black,
        ),
        rightChevronIcon: const Icon(
          Icons.chevron_right,
          color: Palette.black,
        ),
      );

  CalendarStyle get calendarStyle => CalendarStyle(
        disabledTextStyle: _disabledStyle,
        defaultTextStyle: _daysStyle,
        weekendTextStyle: _daysStyle,
        todayTextStyle: _todayStyle,
        rangeStartTextStyle: _rangeStyle,
        rangeEndTextStyle: _rangeStyle,
        todayDecoration: const BoxDecoration(color: Colors.transparent),
        rangeStartDecoration: _rangeDecoration,
        rangeEndDecoration: _rangeDecoration,
        rangeHighlightColor: Palette.matTurquoise.withOpacity(0.4),
        withinRangeDecoration: const BoxDecoration(color: Colors.transparent),
      );
}
