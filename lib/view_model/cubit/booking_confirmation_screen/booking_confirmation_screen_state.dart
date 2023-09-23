part of 'booking_confirmation_screen_cubit.dart';

@immutable
sealed class BookingConfirmationScreenState {
  final BookingConfirmation? bookingConfirmation;
  final String? errorMessage;
  const BookingConfirmationScreenState({this.bookingConfirmation, this.errorMessage});
}

final class BookingConfirmationScreenInitial
    extends BookingConfirmationScreenState {}

final class BookingConfirmationScreenLoading
    extends BookingConfirmationScreenState {}

final class BookingConfirmationScreenLoaded
    extends BookingConfirmationScreenState {
  const BookingConfirmationScreenLoaded({required super.bookingConfirmation});
}

final class BookingConfirmationScreenError
    extends BookingConfirmationScreenState {
  const BookingConfirmationScreenError({super.errorMessage});
}
