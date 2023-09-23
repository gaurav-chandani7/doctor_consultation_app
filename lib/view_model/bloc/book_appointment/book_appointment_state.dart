part of 'book_appointment_bloc.dart';

@immutable
sealed class BookAppointmentState {
  final DoctorDetail selectedDoctor;
  final int? selectedDayIndex;
  final int? selectedTimeIndex;
  final String? selectedDuration;
  final String? selectedPackage;
  const BookAppointmentState(
      {required this.selectedDoctor,
      this.selectedDayIndex,
      this.selectedTimeIndex,
      this.selectedDuration,
      this.selectedPackage});
}

final class BookAppointmentInitial extends BookAppointmentState {
  const BookAppointmentInitial({required DoctorDetail selectedDoctor})
      : super(selectedDoctor: selectedDoctor);
}

final class BookAppointmentDayTimeSelected extends BookAppointmentState {
  const BookAppointmentDayTimeSelected(
      {required super.selectedDoctor,
      super.selectedDayIndex,
      super.selectedTimeIndex});
}

final class BookAppointmentPackageSelected extends BookAppointmentState {
  BookAppointmentPackageSelected(
      {required BookAppointmentState oldState,
      super.selectedDuration,
      super.selectedPackage})
      : super(
            selectedDoctor: oldState.selectedDoctor,
            selectedDayIndex: oldState.selectedDayIndex,
            selectedTimeIndex: oldState.selectedTimeIndex);
}

final class BookAppointmentEntireStateEdited extends BookAppointmentState {
  const BookAppointmentEntireStateEdited(
      {required super.selectedDoctor,
      required super.selectedDayIndex,
      required super.selectedTimeIndex,
      required super.selectedDuration,
      required super.selectedPackage});
}
