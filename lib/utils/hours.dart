import 'package:schedule_calendar/models/models.dart';
import 'package:schedule_calendar/utils/utils.dart';

List<Duration> hours(List<ScheduleModel> scheduledTimes, {int selectedDuration = 60}) {
  final hours = <Duration>[];
  // Sorts the list based on their [startTime]
  scheduledTimes.sort((a, b) => a.startTime.compareTo(b.startTime));
  final hoursWithDuration = scheduledTimes
      .map((e) => {
            "startTime": e.startTime,
            "duration": e.durationByMinutes,
          })
      .toList();

  for (int index = 8; index <= 20; index++) {
    final hour = index.hours;

    // Checks if current hour is existing in [hoursWithDuration] and has 120 mins of Duration.
    // Skips the current and next hour if the condition is true.
    final shouldSkip2Hours = hoursWithDuration.any((hr) => hr["startTime"] == hour && hr["duration"] == 120);
    if (shouldSkip2Hours) {
      index += 1;
      continue;
    }

    // Checks if current hour is existing in [hoursWithDuration] and has 60 mins of Duration.
    // Skips the current if the condition is true.
    final shouldSkip1Hours = hoursWithDuration.any((hr) => hr["startTime"] == hour && hr["duration"] == 60);
    if (shouldSkip1Hours) continue;

    // Checks if current hour is existing in [hoursWithDuration] with [XX:00] format and has 30 mins of Duration.
    // Proceeds to the next condition if condition is true 'cause it will check the [XX:30] format.
    final shouldSkip30mins = hoursWithDuration.any((hr) => hr["startTime"] == hour && hr["duration"] == 30);
    if (!shouldSkip30mins) hours.add(hour);

    // Checks if hours will be rendered by 30 mins - [has30mins]
    if (selectedDuration == 30) {
      // Adds 30 mins to the current hour
      final hourWith30mins = Duration(hours: hour.inHours, minutes: 30);

      // Checks if [hourWith30mins] is existing in [hoursWithDuration] and has 30 mins of Duration.
      // Skips the current hour if the condition is true
      final shouldSkip30mins = hoursWithDuration.any((hr) => hr["startTime"] == hourWith30mins && hr["duration"] == 30);
      if (shouldSkip30mins) continue;

      // If the condition is false, it will be added to [hours]
      hours.add(hourWith30mins);
    }
  }

  return selectedDuration == 120 ? _removeHours(hours) : hours;
}

List<Duration> _removeHours(List<Duration> hours) {
  final newHours = [...hours];

  for (int index = 0; index <= newHours.length - 1; index++) {
    final currentHour = newHours[index];
    final nextHour = Duration(hours: currentHour.inHours + 1, minutes: 0);

    if (index == (newHours.length - 1)) continue;
    if (newHours.contains(nextHour)) continue;

    newHours.remove(currentHour);
  }

  return newHours;
}
