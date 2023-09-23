import 'package:bloc/bloc.dart';
import 'package:doctor_consultation_app/models/app_exception.dart';
import 'package:doctor_consultation_app/models/appointment_options.dart';
import 'package:doctor_consultation_app/models/repositories/doctor_repo.dart';
import 'package:meta/meta.dart';

part 'select_package_screen_state.dart';

class SelectPackageScreenCubit extends Cubit<SelectPackageScreenState> {
  SelectPackageScreenCubit() : super(SelectPackageScreenInitial());

  fetchAppointmentOptions() async {
    emit(SelectPackageScreenLoading());
    try {
      var res = await DoctorRepo().fetchAppointmentOptions();
      emit(SelectPackageScreenLoaded(appointmentOptions: res));
    } catch (e) {
      if (e is AppException) {
        emit(SelectPackageScreenError(errorMessage: e.message));
      } else {
        emit(const SelectPackageScreenError(
            errorMessage: "Something went wrong"));
      }
    }
  }

  refreshScreen() {
    emit(state);
  }
}
