part of 'events_bloc.dart';

@immutable
sealed class EventsEvent {}

class EventsInitialFetchEvent extends EventsEvent {}

class EventSelected extends EventsEvent {
  final EventModel selectedEvent;

  EventSelected(this.selectedEvent);
}
