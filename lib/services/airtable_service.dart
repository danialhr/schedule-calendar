import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:schedule_calendar/constants/constants.dart';
import 'package:schedule_calendar/models/models.dart';
import 'package:http/http.dart' as http;

class AirtableService {
  final _baseUrl = dotenv.env['BASE_URL'];
  final _apiKey = dotenv.env['API_KEY'];
  final _domainId = dotenv.env['SCHEMA_ID'];

  // Retrieve all coaches
  Future<List<CoachModel>> getCoaches() async {
    final url = Uri.parse('$_baseUrl/$_domainId/Coaches');
    final header = {"Authorization": "Bearer $_apiKey"};

    final response = await http.get(url, headers: header);

    if (response.statusCode != 200) throw Exception(response.body);

    final result = json.decode(response.body);

    final coaches = (result[records] as List).map((coach) => CoachModel.fromJson(coach)).toList();

    return coaches;
  }

  // Retrieve all events of coaches
  Future<List<EventModel>> getCoachEvents() async {
    final url = Uri.parse('$_baseUrl/$_domainId/Events');
    final header = {"Authorization": "Bearer $_apiKey"};

    final response = await http.get(url, headers: header);

    if (response.statusCode != 200) throw Exception(response.body);

    final result = json.decode(response.body);

    final events = (result[records] as List).map((event) => EventModel.fromJson(event)).toList();

    return events;
  }

  // Retrieve all scheduled events
  Future<List<ScheduleModel>> getScheduledEvents() async {
    final url = Uri.parse('$_baseUrl/$_domainId/Schedules');
    final header = {"Authorization": "Bearer $_apiKey"};

    final response = await http.get(url, headers: header);

    if (response.statusCode != 200) throw Exception(response.body);

    final result = json.decode(response.body);

    final schedules = (result[records] as List).map((schedule) => ScheduleModel.fromJson(schedule)).toList();

    return schedules;
  }

  // Sends schedule events to API
  Future<List<ScheduleModel>> addScheduledEvents(List<ScheduleModel> schedulesToAdd) async {
    final url = Uri.parse('$_baseUrl/$_domainId/Schedules');
    final header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_apiKey",
    };

    final schedules = schedulesToAdd.map((schedule) => {"fields": schedule.toJson()}).toList();

    final response = await http.post(url, headers: header, body: json.encode({"records": schedules}));

    if (response.statusCode != 200) throw Exception(response.body);

    final result = json.decode(response.body);

    final newSchedules = (result[records] as List).map((schedule) => ScheduleModel.fromJson(schedule)).toList();

    return newSchedules;
  }
}
