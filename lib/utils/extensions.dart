import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/models/models.dart';

// BuildContext
extension ContextExt on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  ThemeData get appTheme => Theme.of(this);
}

// DateTime
extension DateTimeExt on DateTime {
  DateTime get withoutTime => DateTime(year, month, day);
}

// Duration
extension DurationExt on Duration {
  String get formattedTime => ('$inHours:${inMinutes.remainder(60).toString().padRight(2, '0')}');
}

// Event Model
extension EventModelExt on EventModel {
  bool get _isMultipleSession => sessionType == "Multiple";
  bool get _isInPerson => type == "In-Person";

  String get icon => _isInPerson ? personWalkingIcon : callIcon;
  String get formattedDuration => '$durationInMinutes mins';
  String get formattedType => _isMultipleSession ? sessionType : session;
}

// Int
extension IntWithDurationExt on int {
  Duration get year => Duration(days: this * 365);
  Duration get hours => Duration(hours: this);
  Duration get minutes => Duration(minutes: this);
}

// Schedule Model
extension ScheduleModelExt on ScheduleModel {
  String get formattedDate => DateFormat('EEEE, dd MMMM, yyyy').format(date);
  String get formattedTime => '${startTime.formattedTime} - ${endTime.formattedTime}';
  String get formattedDuration => '$durationByMinutes mins';
}
