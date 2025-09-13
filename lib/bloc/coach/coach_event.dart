part of 'coach_bloc.dart';

@immutable
sealed class CoachEvent {}

class CoachInitialFetchEvent extends CoachEvent {}
