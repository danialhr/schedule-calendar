part of 'schedules_bloc.dart';

@immutable
sealed class SchedulesEvent {}

class SchedulesInitialFetchEvent extends SchedulesEvent {}

class SchedulesToAddEvent extends SchedulesEvent {
  final List<ScheduleModel> schedulesToAdd;

  SchedulesToAddEvent(this.schedulesToAdd);
}

class SchedulesSendToApiEvent extends SchedulesEvent {}
