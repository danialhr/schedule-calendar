import 'package:flutter/material.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/utils/utils.dart';
import 'package:schedule_calendar/widgets/widgets.dart';

class HourList extends StatefulWidget {
  const HourList({
    required this.hours,
    this.onSelectTime,
    super.key,
  });

  final List<Duration> hours;
  final void Function(Duration?)? onSelectTime;

  @override
  State<HourList> createState() => _HourListState();
}

class _HourListState extends State<HourList> {
  late Duration? selectedHour;
  late List<Duration> hourList;

  @override
  void initState() {
    super.initState();
    selectedHour = null;
    hourList = widget.hours;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: hourList.length,
        separatorBuilder: (_, __) => const VerticalSpace(26.0),
        itemBuilder: (_, index) => Row(
          children: [
            if (selectedHour != hourList[index]) ...[
              Expanded(
                child: ScheduleCalendarButton(
                  text: hourList[index].formattedTime,
                  onTap: () => _onSelectTime(hourList[index]),
                ),
              ),
            ] else ...[
              Expanded(
                child: ScheduleCalendarButton(
                  text: hourList[index].formattedTime,
                  onTap: () => _onSelectTime(null),
                  buttonColor: Palette.matTurquoise,
                ),
              ),
              const HorizontalSpace(10.0),
              Expanded(
                child: ScheduleCalendarButton(
                  text: next,
                  buttonColor: Palette.blackPanther,
                  onTap: () => widget.onSelectTime?.call(selectedHour),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _onSelectTime(Duration? time) => setState(() => selectedHour = time);
}
