import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_calendar/models/models.dart';
import 'package:schedule_calendar/services/airtable_service.dart';
import 'package:schedule_calendar/services/injection_container.dart';

part 'coach_event.dart';
part 'coach_state.dart';

class CoachBloc extends Bloc<CoachEvent, CoachState> {
  CoachBloc() : super(CoachInitial()) {
    on<CoachInitialFetchEvent>(_coachInitialFetchEvent);
  }

  Future<void> _coachInitialFetchEvent(CoachInitialFetchEvent event, Emitter<CoachState> emit) async {
    try {
      emit(CoachLoading());
      final coach = await getIt<AirtableService>().getCoaches();

      // We are getting the first coach only as the app start it already has a selected coach.
      // This might change when screen for choosing a coach is implemented
      emit(CoachSuccess(coach[0]));
    } catch (e) {
      emit(CoachError(e.toString()));
    }
  }
}
