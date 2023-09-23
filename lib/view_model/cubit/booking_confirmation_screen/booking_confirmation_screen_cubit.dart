import 'package:bloc/bloc.dart';
import 'package:doctor_consultation_app/models/app_exception.dart';
import 'package:doctor_consultation_app/models/booking_confirmation.dart';
import 'package:doctor_consultation_app/models/repositories/doctor_repo.dart';
import 'package:meta/meta.dart';

part 'booking_confirmation_screen_state.dart';

class BookingConfirmationScreenCubit
    extends Cubit<BookingConfirmationScreenState> {
  BookingConfirmationScreenCubit() : super(BookingConfirmationScreenInitial());
  fetchBookingConfirmation() async {
    emit(BookingConfirmationScreenLoading());
    try {
      var res = await DoctorRepo().getBookingConfirmation();
      emit(BookingConfirmationScreenLoaded(bookingConfirmation: res));
    } catch (e) {
      if (e is AppException) {
        emit(BookingConfirmationScreenError(errorMessage: e.message));
      } else {
        emit(const BookingConfirmationScreenError(
            errorMessage: "Something went wrong"));
      }
    }
  }
}
