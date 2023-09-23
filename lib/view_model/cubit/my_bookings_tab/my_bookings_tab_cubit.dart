import 'package:bloc/bloc.dart';
import 'package:doctor_consultation_app/models/app_exception.dart';
import 'package:doctor_consultation_app/models/my_booking.dart';
import 'package:doctor_consultation_app/models/repositories/doctor_repo.dart';
import 'package:meta/meta.dart';

part 'my_bookings_tab_state.dart';

class MyBookingsTabCubit extends Cubit<MyBookingsTabState> {
  MyBookingsTabCubit() : super(MyBookingsTabInitial());

  fetchBookings() async {
    emit(MyBookingsTabLoading());
    try {
      var list = await DoctorRepo().fetchMyBookings();
      emit(MyBookingsTabLoaded(myBooking: list));
    } catch (e) {
      if (e is AppException) {
        emit(MyBookingsTabError(errorMessage: e.message));
      } else {
        emit(const MyBookingsTabError(errorMessage: "Something went wrong"));
      }
    }
  }
}
