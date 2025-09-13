import 'package:intl/intl.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/utils/utils.dart';

class ScheduleModel {
  String? id;
  String? notes;
  DateTime date;
  Duration startTime;
  Duration endTime;
  String eventId;
  int? durationByMinutes;

  ScheduleModel({
    this.id,
    this.durationByMinutes,
    this.notes,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.eventId,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    final startTime = json["fields"]["startTime"].split(":");
    final endTime = json["fields"]["endTime"].split(":");

    return ScheduleModel(
      id: json['id'],
      notes: json["fields"]["notes"],
      date: DateTime.parse(json["fields"]["date"]),
      startTime: Duration(hours: int.parse(startTime.first), minutes: int.parse(startTime.last)),
      endTime: Duration(hours: int.parse(endTime.first), minutes: int.parse(endTime.last)),
      eventId: json["fields"]["eventId"].first,
      durationByMinutes: json["fields"]["durationByMinutes (from eventId)"].first,
    );
  }

  Map<String, dynamic> toJson() => {
        "notes": notes,
        "date": DateFormat(dateFormat).format(date),
        "startTime": startTime.formattedTime,
        "endTime": endTime.formattedTime,
        "eventId": [eventId],
      };

  @override
  String toString() {
    super.toString();
    return 'ScheduleModel(notes: $notes, date: $date, startTime: $startTime, endTime: $endTime, eventId: $eventId)';
  }
}
