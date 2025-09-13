import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_calendar/bloc/events/events_bloc.dart';
import 'package:schedule_calendar/bloc/schedules/schedules_bloc.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/models/schedule_model.dart';
import 'package:schedule_calendar/screens/screens.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

const double _closeButtonSize = 34.0;

class InvitationSentScreen extends StatelessWidget {
  static const String routeName = '/invitation-sent-screen';

  const InvitationSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Palette.lushGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _navigateToHomeScreen(context),
                child: Container(
                  height: _closeButtonSize,
                  width: _closeButtonSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.white,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Palette.lushGreen,
                  ),
                ),
              ),
              const VerticalSpace(45.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  children: [
                    BlocBuilder<EventsBloc, EventsState>(
                      builder: (context, state) {
                        if (state is! EventsSuccess) return const SizedBox();

                        final selectedEvent = state.selectedEvent;

                        return Text(
                          'Your ${selectedEvent?.title} sessions invitation has been sent to',
                          style: textTheme.headlineLarge,
                        );
                      },
                    ),
                    const VerticalSpace(24.0),
                    const UserProfile(
                      imageUrl: userImage,
                      textColor: Palette.blancoWhite,
                    ),
                    const VerticalSpace(24.0),
                    BlocBuilder<SchedulesBloc, SchedulesState>(
                      builder: (context, state) {
                        if (state is! SchedulesSuccess) {
                          return const Center(child: CircularProgressIndicator.adaptive());
                        }

                        final schedules = state.schedulesToAdd ?? [];

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: schedules.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      schedules[index].formattedDate,
                                      style: textTheme.bodySmall?.copyWith(color: Palette.blancoWhite),
                                    ),
                                    const VerticalSpace(8.0),
                                    Text(
                                      schedules[index].formattedTime,
                                      style: textTheme.bodySmall?.copyWith(color: Palette.blancoWhite),
                                    ),
                                  ],
                                ),
                                ScheduleCalendarButton(
                                  text: schedules[index].formattedDuration,
                                  buttonColor: Palette.matGreen,
                                  textStyle: textTheme.bodyLarge?.copyWith(color: Palette.white),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const VerticalSpace(16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(globeWhiteIcon),
                        const HorizontalSpace(8.0),
                        Text(
                          singaporeStandardTime,
                          style: textTheme.bodyLarge?.copyWith(
                            color: Palette.blancoWhite,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const VerticalSpace(32.0),
              Center(
                child: SizedBox(
                  width: size.width * 0.9,
                  child: ScheduleCalendarButton(
                    text: viewYourCalendar,
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    customBorderColor: Palette.blancoWhite,
                    textStyle: textTheme.titleLarge?.copyWith(
                      color: Palette.blancoWhite,
                      fontWeight: FontWeight.w400,
                    ),
                    borderRadius: 18.0,
                  ),
                ),
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.only(top: 32.0),
                child: InkWell(
                  onTap: () => _navigateToHomeScreen(context),
                  child: Text(
                    done,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge?.copyWith(
                      color: Palette.blancoWhite,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    context.read<SchedulesBloc>().add(SchedulesToAddEvent(const <ScheduleModel>[]));
    context.navigator.pushNamedAndRemoveUntil(
      HomeScreen.routeName,
      (route) => false,
    );
  }
}
