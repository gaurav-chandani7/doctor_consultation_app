part of 'my_bookings_tab_cubit.dart';

@immutable
sealed class MyBookingsTabState {
  final List<MyBooking>? myBooking;
  final String? errorMessage;
  const MyBookingsTabState({this.myBooking, this.errorMessage});
}

final class MyBookingsTabInitial extends MyBookingsTabState {}

final class MyBookingsTabLoading extends MyBookingsTabState {}

final class MyBookingsTabLoaded extends MyBookingsTabState {
  const MyBookingsTabLoaded({required super.myBooking});
}

final class MyBookingsTabError extends MyBookingsTabState {
  const MyBookingsTabError({super.errorMessage});
}
