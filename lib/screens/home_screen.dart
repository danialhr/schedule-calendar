import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_calendar/bloc/coach/coach_bloc.dart';
import 'package:schedule_calendar/bloc/events/events_bloc.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/screens/select_event_date_screen.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

const double _addIconSize = 40.0;

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: const SchedulCalendarAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ScheduleCalendarBottomSheet(
            height: size.height * 0.25,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    maxLines: 4,
                    style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: writeMessage,
                      hintStyle: textTheme.labelLarge?.copyWith(
                        color: Palette.mistyGrey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => _showBottomSheet(context),
                        icon: SvgPicture.asset(calendarIcon),
                      ),
                      Container(
                        height: _addIconSize,
                        width: _addIconSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.boscoGrey,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          color: Palette.white,
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = context.appTheme.textTheme;

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return ScheduleCalendarBottomSheet(
          height: size.height * 0.45,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<CoachBloc, CoachState>(
                    builder: (context, state) {
                      if (state is! CoachSuccess) return const SizedBox();

                      return Text(
                        "${state.coach.firstName}'s Calendar",
                        style: textTheme.titleLarge,
                      );
                    },
                  ),
                  const VerticalSpace(26.0),
                  BlocBuilder<EventsBloc, EventsState>(
                    builder: (context, state) {
                      if (state is! EventsSuccess) {
                        return Column(
                          children: List.generate(3, (index) => EventTile.loading()),
                        );
                      }

                      final events = state.events;

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: events.length,
                        itemBuilder: (_, index) => EventTile(
                          event: events[index],
                          onPressed: () {
                            context.read<EventsBloc>().add(EventSelected(events[index]));
                            context.navigator.pop();
                            context.navigator.pushNamed(SelectEventDateScreen.routeName);
                          },
                        ),
                      );
                    },
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        seeMore,
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
