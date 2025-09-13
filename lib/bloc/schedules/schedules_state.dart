part of 'schedules_bloc.dart';

@immutable
sealed class SchedulesState {}

final class SchedulesInitial extends SchedulesState {}

final class SchedulesLoading extends SchedulesState {}

final class SchedulesSuccess extends SchedulesState {
  final List<ScheduleModel> schedules;
  final List<ScheduleModel>? schedulesToAdd;

  SchedulesSuccess({
    required this.schedules,
    this.schedulesToAdd,
  });
}

final class SchedulesError extends SchedulesState {
  final String message;

  SchedulesError(this.message);
}
