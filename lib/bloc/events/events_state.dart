part of 'events_bloc.dart';

@immutable
sealed class EventsState {}

final class EventsInitial extends EventsState {
  final List<EventModel> events;
  final EventModel? selectedEvent;

  EventsInitial({
    required this.events,
    this.selectedEvent,
  });
}

final class EventsLoading extends EventsState {}

final class EventsSuccess extends EventsState {
  final List<EventModel> events;
  final EventModel? selectedEvent;

  EventsSuccess({
    required this.events,
    this.selectedEvent,
  });
}

final class EventsError extends EventsState {
  final String message;

  EventsError(this.message);
}
