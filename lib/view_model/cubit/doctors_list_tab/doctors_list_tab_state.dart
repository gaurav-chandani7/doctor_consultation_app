part of 'doctors_list_tab_cubit.dart';

@immutable
sealed class DoctorsListTabState {
  final List<DoctorDetail>? doctorList;
  final String? errorMessage;
  const DoctorsListTabState({this.doctorList, this.errorMessage});
}

final class DoctorsListTabInitial extends DoctorsListTabState {}

final class DoctorsListTabLoading extends DoctorsListTabState {}

final class DoctorsListTabLoaded extends DoctorsListTabState {
  const DoctorsListTabLoaded({required List<DoctorDetail> doctorList})
      : super(doctorList: doctorList);
}

final class DoctorsListTabError extends DoctorsListTabState {
  const DoctorsListTabError([String? errorMessage])
      : super(errorMessage: errorMessage);
}
