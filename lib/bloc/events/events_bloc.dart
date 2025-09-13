import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_calendar/models/models.dart';
import 'package:schedule_calendar/services/airtable_service.dart';
import 'package:schedule_calendar/services/injection_container.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitial(events: const <EventModel>[])) {
    on<EventsInitialFetchEvent>(_eventsInitialFetchEvent);
    on<EventSelected>(_eventSelected);
  }

  Future<void> _eventsInitialFetchEvent(EventsInitialFetchEvent event, Emitter<EventsState> emit) async {
    try {
      emit(EventsLoading());

      final events = await getIt<AirtableService>().getCoachEvents();

      emit(EventsSuccess(events: events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  void _eventSelected(EventSelected event, Emitter<EventsState> emit) {
    final events = (state as EventsSuccess).events;

    emit(EventsSuccess(
      events: events,
      selectedEvent: event.selectedEvent,
    ));
  }
}
