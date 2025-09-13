import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule_calendar/bloc/schedules/schedules_bloc.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/screens/screens.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

class SelectEventDateScreen extends StatelessWidget {
  static const String routeName = '/select-event-date';

  const SelectEventDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;

    return EventScreenView(
      contents: [
        Center(
          child: Text(
            selectADay,
            style: textTheme.bodyLarge,
          ),
        ),
        Expanded(
          child: BlocBuilder<SchedulesBloc, SchedulesState>(
            builder: (context, state) {
              if (state is! SchedulesSuccess) return const Center(child: CircularProgressIndicator.adaptive());

              final scheduleDates = state.schedules.map((e) => DateFormat(dateFormat).format(e.date)).toList();
              final schedulesToAdd = state.schedulesToAdd;

              return Calendar(
                scheduledDates: scheduleDates,
                schedulesToAdd: schedulesToAdd,
                onDaySelected: (selectedDay, _) {
                  if (scheduleDates.contains(DateFormat(dateFormat).format(selectedDay))) return;

                  context.navigator.pushNamed(
                    SelectEventTimeScreen.routeName,
                    arguments: selectedDay,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
