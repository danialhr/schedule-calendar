import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:schedule_calendar/bloc/events/events_bloc.dart';
import 'package:schedule_calendar/bloc/schedules/schedules_bloc.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/models/models.dart';
import 'package:schedule_calendar/screens/screens.dart';
import 'package:schedule_calendar/utils/hours.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

class SelectEventTimeScreen extends StatelessWidget {
  static const String routeName = '/select-event-time';

  const SelectEventTimeScreen({
    required this.selectedDate,
    super.key,
  });

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;
    final size = MediaQuery.of(context).size;
    final day = DateFormat(fullDayFormat).format(selectedDate);
    final formattedDate = DateFormat(fullDateFormat).format(selectedDate);

    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        final event = (state as EventsSuccess).selectedEvent;
        final isMultipleSession = event?.sessionType == 'Multiple';

        return Scaffold(
          appBar: SchedulCalendarAppBar(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Hero(
                tag: 'AppBarTitle',
                child: Text(
                  '${event?.title}',
                  style: textTheme.labelLarge,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 21.0,
              left: 26.0,
              right: 26.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'EventInfoRow',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SquareButton(
                        title: SvgPicture.asset(event?.icon ?? personWalkingIcon),
                        subtitle: '${event?.type}',
                        tooltipMessage: isMultipleSession ? locationTooltipMessage : null,
                      ),
                      SquareButton(
                        title: SvgPicture.asset(clockIcon),
                        subtitle: '${event?.formattedDuration}',
                        tooltipMessage: durationTooltipMessage,
                      ),
                      SquareButton(
                        title: Text(
                          isMultipleSession ? '+1' : '1',
                          style: textTheme.headlineLarge?.copyWith(
                            color: Palette.ashGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: '${event?.formattedType}',
                        tooltipMessage: isMultipleSession ? locationTooltipMessage : null,
                      ),
                    ],
                  ),
                ),
                const VerticalSpace(30.0),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Palette.matPastelGreen,
                  ),
                  child: Column(
                    children: [
                      Text(
                        day,
                        style: textTheme.bodyLarge?.copyWith(
                          color: Palette.blackPanther,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: textTheme.bodyLarge?.copyWith(
                          color: Palette.blackPanther,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpace(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(globeIcon),
                    const HorizontalSpace(8.0),
                    Text(
                      singaporeStandardTime,
                      style: textTheme.bodyLarge?.copyWith(
                        color: Palette.ashGrey,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
                const VerticalSpace(20.0),
                Text(
                  selectATime,
                  style: textTheme.bodyLarge,
                ),
                const VerticalSpace(10.0),
                Text(
                  'Duration: ${event?.formattedDuration}',
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const VerticalSpace(26.0),
                Expanded(
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: BlocBuilder<SchedulesBloc, SchedulesState>(
                      builder: (context, state) {
                        if (state is! SchedulesSuccess || event == null) return const SizedBox();

                        final schedules = [...state.schedules, ...state.schedulesToAdd ?? <ScheduleModel>[]];

                        return HourList(
                          hours: hours(
                            schedules,
                            selectedDuration: event.durationInMinutes,
                          ),
                          onSelectTime: (selectedTime) => _onSelectTime(
                            context,
                            selectedTime: selectedTime,
                            event: event,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSelectTime(
    BuildContext context, {
    Duration? selectedTime,
    required EventModel event,
  }) {
    if (selectedTime == null) return;

    final scheduleToAdd = ScheduleModel(
      notes: emptyString,
      date: selectedDate,
      startTime: selectedTime,
      endTime: selectedTime + event.durationInMinutes.minutes,
      eventId: event.id,
      durationByMinutes: event.durationInMinutes,
    );

    final prevState = context.read<SchedulesBloc>().state as SchedulesSuccess;
    final prevSchedulesToAdd = prevState.schedulesToAdd ?? <ScheduleModel>[];
    final isExisting = prevSchedulesToAdd.any((prevSched) => prevSched.startTime == scheduleToAdd.startTime);

    if (isExisting == false) {
      context.read<SchedulesBloc>().add(SchedulesToAddEvent([...prevSchedulesToAdd, scheduleToAdd]));
    }

    context.navigator.pushNamed(ScheduleSessionScreen.routeName);
  }
}
