import 'package:bloc/bloc.dart';
import 'package:doctor_consultation_app/models/doctor_detail.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'book_appointment_event.dart';
part 'book_appointment_state.dart';

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  BookAppointmentBloc({required DoctorDetail selectedDoctor})
      : super(BookAppointmentInitial(selectedDoctor: selectedDoctor)) {
    on<SelectDayEvent>((event, emit) {
      if (state.selectedDayIndex == event.index) {
        // Tapped on selected chip
        // Unselect both day and time
        emit(BookAppointmentDayTimeSelected(
            selectedDoctor: state.selectedDoctor,
            selectedDayIndex: null,
            selectedTimeIndex: null));
      } else {
        emit(BookAppointmentDayTimeSelected(
            selectedDoctor: state.selectedDoctor,
            selectedDayIndex: event.index));
      }
    });
    on<SelectTimeEvent>((event, emit) {
      // Tapped on selected chip
      if (state.selectedTimeIndex == event.index) {
        emit(BookAppointmentDayTimeSelected(
            selectedDoctor: state.selectedDoctor,
            selectedDayIndex: state.selectedDayIndex));
      } else {
        emit(BookAppointmentDayTimeSelected(
            selectedDoctor: state.selectedDoctor,
            selectedDayIndex: state.selectedDayIndex,
            selectedTimeIndex: event.index));
      }
    });

    on<SelectDurationEvent>((event, emit) {
      emit(BookAppointmentPackageSelected(
          oldState: state,
          selectedDuration: event.duration,
          selectedPackage: state.selectedPackage));
    });

    on<SelectPackageEvent>((event, emit) {
      emit(BookAppointmentPackageSelected(
          oldState: state,
          selectedPackage: event.package,
          selectedDuration: state.selectedDuration));
    });

    on<EditCompleteAppointmentEvent>((event, emit) {
      emit(BookAppointmentEntireStateEdited(
          selectedDoctor: state.selectedDoctor,
          selectedDayIndex: event.dayIndex,
          selectedTimeIndex: event.timeIndex,
          selectedDuration: event.duration,
          selectedPackage: event.package));
    });
  }
}
