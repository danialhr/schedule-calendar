part of 'coach_bloc.dart';

@immutable
sealed class CoachState {}

final class CoachInitial extends CoachState {}

final class CoachLoading extends CoachState {}

final class CoachSuccess extends CoachState {
  final CoachModel coach;

  CoachSuccess(this.coach);
}

final class CoachError extends CoachState {
  final String message;

  CoachError(this.message);
}
