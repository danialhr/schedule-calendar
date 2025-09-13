import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_calendar/models/models.dart';
import 'package:schedule_calendar/services/airtable_service.dart';
import 'package:schedule_calendar/services/injection_container.dart';

part 'schedules_event.dart';
part 'schedules_state.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc() : super(SchedulesInitial()) {
    on<SchedulesInitialFetchEvent>(_schedulesInitialFetchEvent);
    on<SchedulesToAddEvent>(_schedulesToAddEvent);
    on<SchedulesSendToApiEvent>(_schedulesSendToApiEvent);
  }

  Future<void> _schedulesInitialFetchEvent(SchedulesInitialFetchEvent event, Emitter<SchedulesState> emit) async {
    try {
      emit(SchedulesLoading());

      final schedules = await getIt<AirtableService>().getScheduledEvents();

      emit(SchedulesSuccess(schedules: schedules));
    } catch (e) {
      emit(SchedulesError(e.toString()));
    }
  }

  void _schedulesToAddEvent(SchedulesToAddEvent event, Emitter<SchedulesState> emit) {
    if (state is! SchedulesSuccess) return;

    final prevSchedules = (state as SchedulesSuccess).schedules;

    emit(SchedulesSuccess(
      schedules: prevSchedules,
      schedulesToAdd: event.schedulesToAdd,
    ));
  }

  Future<void> _schedulesSendToApiEvent(SchedulesSendToApiEvent event, Emitter<SchedulesState> emit) async {
    final prevSchedulesToAdd = (state as SchedulesSuccess).schedulesToAdd;
    final prevSchedules = (state as SchedulesSuccess).schedules;

    try {
      emit(SchedulesLoading());

      if (prevSchedulesToAdd == null) return;

      final schedules = await getIt<AirtableService>().addScheduledEvents(prevSchedulesToAdd);

      prevSchedules.addAll(schedules);

      emit(SchedulesSuccess(schedules: prevSchedules, schedulesToAdd: schedules));
    } catch (e) {
      emit(SchedulesError(e.toString()));
    }
  }
}
