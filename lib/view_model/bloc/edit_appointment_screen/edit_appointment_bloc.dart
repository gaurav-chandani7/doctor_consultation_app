import 'package:bloc/bloc.dart';
import 'package:doctor_consultation_app/view_model/bloc/book_appointment/book_appointment_bloc.dart';
import 'package:meta/meta.dart';

part 'edit_appointment_event.dart';
part 'edit_appointment_state.dart';

class EditAppointmentBloc
    extends Bloc<EditAppointmentEvent, EditAppointmentState> {
  EditAppointmentBloc({required BookAppointmentState preEditingState})
      : super(EditAppointmentInitial(preEditingState: preEditingState)) {
    on<EditDayOfAppointmentEvent>((event, emit) {
      if (state.selectedDayIndex == event.dayIndex) {
        //Uncheck day and time
        emit(EditAppointmentEditedState(
            selectedDayIndex: null,
            selectedTimeIndex: null,
            selectedDuration: state.selectedDuration,
            selectedPackage: state.selectedPackage));
      } else {
        emit(EditAppointmentEditedState(
            selectedDayIndex: event.dayIndex,
            selectedTimeIndex: null,
            selectedDuration: state.selectedDuration,
            selectedPackage: state.selectedPackage));
      }
    });

    on<EditTimeOfAppointmentEvent>((event, emit) {
      if (state.selectedTimeIndex == event.timeIndex) {
        //Uncheck time
        emit(EditAppointmentEditedState(
            selectedDayIndex: state.selectedDayIndex,
            selectedTimeIndex: null,
            selectedDuration: state.selectedDuration,
            selectedPackage: state.selectedPackage));
      } else {
        emit(EditAppointmentEditedState(
            selectedDayIndex: state.selectedDayIndex,
            selectedTimeIndex: event.timeIndex,
            selectedDuration: state.selectedDuration,
            selectedPackage: state.selectedPackage));
      }
    });

    on<EditDurationOfAppointmentEvent>((event, emit) {
      emit(EditAppointmentEditedState(
          selectedDayIndex: state.selectedDayIndex,
          selectedTimeIndex: state.selectedTimeIndex,
          selectedDuration: event.duration,
          selectedPackage: state.selectedPackage));
    });

    on<EditPackageOfAppointmentEvent>((event, emit) {
      emit(EditAppointmentEditedState(
          selectedDayIndex: state.selectedDayIndex,
          selectedTimeIndex: state.selectedTimeIndex,
          selectedDuration: state.selectedDuration,
          selectedPackage: event.package));
    });
  }
}
