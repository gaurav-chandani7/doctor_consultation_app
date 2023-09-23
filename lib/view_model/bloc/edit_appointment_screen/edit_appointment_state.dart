part of 'edit_appointment_bloc.dart';

@immutable
sealed class EditAppointmentState {
  // final BookAppointmentState editingState;
  final int? selectedDayIndex;
  final int? selectedTimeIndex;
  final String? selectedDuration;
  final String? selectedPackage;
  const EditAppointmentState(
      {this.selectedDayIndex,
      this.selectedTimeIndex,
      this.selectedDuration,
      this.selectedPackage});
}

final class EditAppointmentInitial extends EditAppointmentState {
  EditAppointmentInitial({required BookAppointmentState preEditingState})
      : super(
            selectedDayIndex: preEditingState.selectedDayIndex,
            selectedTimeIndex: preEditingState.selectedTimeIndex,
            selectedDuration: preEditingState.selectedDuration,
            selectedPackage: preEditingState.selectedPackage);
}

final class EditAppointmentEditedState extends EditAppointmentState {
  const EditAppointmentEditedState(
      {super.selectedDayIndex,
      super.selectedTimeIndex,
      super.selectedDuration,
      super.selectedPackage});
}
