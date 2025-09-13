import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_calendar/bloc/coach/coach_bloc.dart';
import 'package:schedule_calendar/bloc/events/events_bloc.dart';
import 'package:schedule_calendar/bloc/schedules/schedules_bloc.dart';
import 'package:schedule_calendar/config/theme.dart';
import 'package:schedule_calendar/routes/route_manager.dart';
import 'package:schedule_calendar/screens/screens.dart';

class ScheduleCalendar extends StatelessWidget {
  const ScheduleCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoachBloc>(create: (_) => CoachBloc()..add(CoachInitialFetchEvent())),
        BlocProvider<EventsBloc>(create: (_) => EventsBloc()..add(EventsInitialFetchEvent())),
        BlocProvider<SchedulesBloc>(
            create: (_) => SchedulesBloc()
              ..add(SchedulesInitialFetchEvent())
              ..add(SchedulesToAddEvent(List.empty(growable: true)))),
      ],
      child: MaterialApp(
        theme: scheduleCalendarTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeName,
        onGenerateRoute: RouteManager.generateRoute,
        home: const HomeScreen(),
      ),
    );
  }
}
