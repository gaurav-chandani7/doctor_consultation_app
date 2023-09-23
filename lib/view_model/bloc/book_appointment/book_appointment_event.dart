part of 'book_appointment_bloc.dart';

@immutable
sealed class BookAppointmentEvent {}

class SelectDayEvent extends BookAppointmentEvent {
  final int index;
  SelectDayEvent({required this.index});
}

class SelectTimeEvent extends BookAppointmentEvent {
  final int index;
  SelectTimeEvent({required this.index});
}

class SelectDurationEvent extends BookAppointmentEvent {
  final String duration;
  SelectDurationEvent({required this.duration});
}

class SelectPackageEvent extends BookAppointmentEvent {
  final String package;
  SelectPackageEvent({required this.package});
}

class EditCompleteAppointmentEvent extends BookAppointmentEvent {
  final int? dayIndex;
  final int? timeIndex;
  final String? duration;
  final String? package;
  EditCompleteAppointmentEvent(
      {required this.dayIndex,
      required this.timeIndex,
      required this.duration,
      required this.package});
}
