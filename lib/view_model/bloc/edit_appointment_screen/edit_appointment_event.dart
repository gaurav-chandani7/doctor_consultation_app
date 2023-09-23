part of 'edit_appointment_bloc.dart';

@immutable
sealed class EditAppointmentEvent {}

class EditDayOfAppointmentEvent extends EditAppointmentEvent {
  final int dayIndex;
  EditDayOfAppointmentEvent({required this.dayIndex});
}

class EditTimeOfAppointmentEvent extends EditAppointmentEvent {
  final int timeIndex;
  EditTimeOfAppointmentEvent({required this.timeIndex});
}

class EditDurationOfAppointmentEvent extends EditAppointmentEvent {
  final String duration;
  EditDurationOfAppointmentEvent({required this.duration});
}

class EditPackageOfAppointmentEvent extends EditAppointmentEvent {
  final String package;
  EditPackageOfAppointmentEvent({required this.package});
}

class EditAnyParameterOfAppointmentEvent extends EditAppointmentEvent {
  final int? dayIndex;
  final int? timeIndex;
  final String? duration;
  final String? package;
  EditAnyParameterOfAppointmentEvent(
      {this.dayIndex, this.timeIndex, this.duration, this.package});
}
