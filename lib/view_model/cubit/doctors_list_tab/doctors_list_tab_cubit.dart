import 'package:bloc/bloc.dart';
import 'package:doctor_consultation_app/models/app_exception.dart';
import 'package:doctor_consultation_app/models/doctor_detail.dart';
import 'package:doctor_consultation_app/models/repositories/doctor_repo.dart';
import 'package:meta/meta.dart';

part 'doctors_list_tab_state.dart';

class DoctorsListTabCubit extends Cubit<DoctorsListTabState> {
  DoctorsListTabCubit() : super(DoctorsListTabInitial());

  fetchDoctorsList() async {
    emit(DoctorsListTabLoading());
    try {
      var list = await DoctorRepo().fetchAllDoctors();
      emit(DoctorsListTabLoaded(doctorList: list));
    } catch (e) {
      if (e is AppException) {
        emit(DoctorsListTabError(e.message ?? ""));
      } else {
        emit(const DoctorsListTabError("Something went wrong"));
      }
    }
  }
}
