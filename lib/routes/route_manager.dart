import 'package:flutter/material.dart';
import 'package:schedule_calendar/screens/screens.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case SelectEventDateScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SelectEventDateScreen());
      case SelectEventTimeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => SelectEventTimeScreen(
            selectedDate: args as DateTime,
          ),
        );
      case ScheduleSessionScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ScheduleSessionScreen());
      case InvitationSentScreen.routeName:
        return MaterialPageRoute(builder: (_) => const InvitationSentScreen());
      default:
        return throw Exception('Error 404');
    }
  }
}
