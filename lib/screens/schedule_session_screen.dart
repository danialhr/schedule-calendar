import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_calendar/bloc/events/events_bloc.dart';
import 'package:schedule_calendar/bloc/schedules/schedules_bloc.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/screens/screens.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

class ScheduleSessionScreen extends StatelessWidget {
  static const String routeName = '/schedule-session-screen';

  const ScheduleSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;
    final size = MediaQuery.of(context).size;

    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is! EventsSuccess) return const SizedBox();

        final selectedEvent = state.selectedEvent;
        final isMultipleSession = selectedEvent?.sessionType == 'Multiple';

        return EventScreenView(
          contents: [
            if (isMultipleSession) ...[
              Center(
                child: SizedBox(
                  width: size.width * 0.6,
                  child: ScheduleCalendarButton(
                    text: addNewEvent,
                    onTap: () => context.navigator.pushNamed(SelectEventDateScreen.routeName),
                  ),
                ),
              ),
            ],
            const VerticalSpace(16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  scheduleEvent,
                  style: textTheme.labelLarge?.copyWith(color: Palette.blackPanther),
                ),
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
              ],
            ),
            const VerticalSpace(16.0),
            Expanded(
              child: BlocBuilder<SchedulesBloc, SchedulesState>(
                builder: (context, state) {
                  if (state is! SchedulesSuccess) return const SizedBox();
                  if (state.schedulesToAdd == null || state.schedulesToAdd?.isEmpty == true) return const SizedBox();

                  final schedulesToAdd = state.schedulesToAdd ?? [];
                  final schedulesToAddLength = state.schedulesToAdd?.length ?? 0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (schedulesToAdd.first.notes == emptyString)
                        SizedBox(
                          width: size.width * 0.5,
                          child: RoundButton(
                            text: addNotes,
                            onTap: () => _showAddNotesBottomSheet(context),
                          ),
                        )
                      else ...[
                        Text(
                          'Note from @sample.client',
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const VerticalSpace(8.0),
                        EllipsisText(text: schedulesToAdd.first.notes),
                      ],
                      const VerticalSpace(14.0),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: schedulesToAdd.length,
                        itemBuilder: (context, index) => EventTile(
                          event: selectedEvent,
                          eventDate: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                schedulesToAdd[index].formattedDate,
                                style: textTheme.bodySmall,
                              ),
                              const VerticalSpace(8.0),
                              Text(
                                schedulesToAdd[index].formattedTime,
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      SafeArea(
                        child: Center(
                          child: SizedBox(
                            width: size.width * 0.8,
                            child: BlocBuilder<SchedulesBloc, SchedulesState>(
                              builder: (context, state) {
                                if (state is! SchedulesSuccess) return const SizedBox();

                                return ScheduleCalendarButton(
                                  buttonColor: Palette.blackPanther,
                                  text: schedulesToAddLength >= 2 ? scheduleSessionFor60 : scheduleSession,
                                  onTap: () => _showTermsAndCondtionBottomSheet(context),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddNotesBottomSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final initialBottomSheetHeight = size.height * 0.25;
    double modalSheetHeight = initialBottomSheetHeight;
    int maxLines = 4;

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (_, setState) {
          final isHeightChanged = modalSheetHeight != initialBottomSheetHeight;

          return BlocBuilder<SchedulesBloc, SchedulesState>(
            builder: (context, state) {
              if (state is! SchedulesSuccess) return const SizedBox();

              final schedulesToAdd = state.schedulesToAdd ?? [];

              return AddNotesSheet(
                height: modalSheetHeight,
                maxLines: maxLines,
                onPressExpand: () {
                  setState(() {
                    modalSheetHeight = isHeightChanged ? initialBottomSheetHeight : size.height * 0.5;
                    maxLines = isHeightChanged ? 4 : 16;
                  });
                },
                onPressAdd: (notes) {
                  for (final schedule in schedulesToAdd) {
                    schedule.notes = notes;
                  }
                  context.read<SchedulesBloc>().add(SchedulesToAddEvent(schedulesToAdd));
                  context.navigator.pop();
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showTermsAndCondtionBottomSheet(BuildContext context) => showModalBottomSheet(
        barrierColor: Palette.black.withOpacity(0.8),
        context: context,
        builder: (_) => TermsAndConditionSheet(
          onLoading: () {
            Future.delayed(
              const Duration(seconds: 1),
              () {
                context.read<SchedulesBloc>().add(SchedulesSendToApiEvent());
                context.navigator.pushNamed(InvitationSentScreen.routeName);
              },
            );
          },
        ),
      );
}
