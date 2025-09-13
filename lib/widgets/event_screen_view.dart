import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_calendar/bloc/events/events_bloc.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';
import 'package:schedule_calendar/utils/extensions.dart';

class EventScreenView extends StatelessWidget {
  const EventScreenView({
    this.contents,
    super.key,
  });

  final List<Widget>? contents;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTheme.textTheme;

    return Scaffold(
      appBar: const SchedulCalendarAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 21.0,
          left: 26.0,
          right: 26.0,
        ),
        child: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            final event = (state as EventsSuccess).selectedEvent;
            final isMultipleSession = event?.sessionType == 'Multiple';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'AppBarTitle',
                  child: Text(
                    '${event?.title}',
                    style: textTheme.labelLarge,
                  ),
                ),
                const VerticalSpace(16.0),
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
                const VerticalSpace(16.0),
                EllipsisText(text: '${event?.description}'),
                const VerticalSpace(16.0),
                if (contents != null) ...contents!,
              ],
            );
          },
        ),
      ),
    );
  }
}
