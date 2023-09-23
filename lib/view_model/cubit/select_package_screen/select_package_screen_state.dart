part of 'select_package_screen_cubit.dart';

@immutable
sealed class SelectPackageScreenState {
  final AppointmentOptions? appointmentOptions;
  final String? errorMessage;
  const SelectPackageScreenState({this.appointmentOptions, this.errorMessage});
}

final class SelectPackageScreenInitial extends SelectPackageScreenState {}

final class SelectPackageScreenLoading extends SelectPackageScreenState {}

final class SelectPackageScreenLoaded extends SelectPackageScreenState {
  const SelectPackageScreenLoaded({required super.appointmentOptions});
}

final class SelectPackageScreenError extends SelectPackageScreenState {
  const SelectPackageScreenError({super.errorMessage});
}
