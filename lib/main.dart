import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:schedule_calendar/schedule_calendar.dart';
import 'package:schedule_calendar/services/injection_container.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  // Initializes get it when app started
  init();

  runApp(const ScheduleCalendar());
}
