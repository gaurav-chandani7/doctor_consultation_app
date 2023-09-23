import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/models/appointment_options.dart';
import 'package:doctor_consultation_app/models/booking_confirmation.dart';
import 'package:doctor_consultation_app/models/doctor_detail.dart';
import 'package:doctor_consultation_app/models/my_booking.dart';
import 'package:doctor_consultation_app/models/services/base_service.dart';
import 'package:doctor_consultation_app/models/services/doctor_service.dart';

class DoctorRepo {
  final BaseService _doctorService = DoctorService();
  Future<List<DoctorDetail>> fetchAllDoctors() async {
    dynamic response = await _doctorService.getResponse("doctors");
    final jsonData = response as List;
    List<DoctorDetail> listOfDoctors =
        jsonData.map((e) => DoctorDetail.fromJson(e)).toList();

    //Giving constant values for images
    for (int i = 0; i < listOfDoctors.length; i++) {
      listOfDoctors[i].image = AppConstants.imageUrls[i % 4];
    }

    return listOfDoctors;
  }

  Future<AppointmentOptions> fetchAppointmentOptions() async {
    dynamic response = await _doctorService.getResponse("appointment_options");
    AppointmentOptions appointmentOptions =
        AppointmentOptions.fromJson(response);
    return appointmentOptions;
  }

  Future<BookingConfirmation> getBookingConfirmation() async {
    dynamic response = await _doctorService.getResponse("booking_confirmation");
    BookingConfirmation bookingConfirmation =
        BookingConfirmation.fromJson(response);
    return bookingConfirmation;
  }

  Future<List<MyBooking>> fetchMyBookings() async {
    dynamic response = await _doctorService.getResponse("appointments");
    final jsonData = response as List;
    List<MyBooking> listOfBooking =
        jsonData.map((e) => MyBooking.fromJson(e)).toList();

    //Giving constant values for images
    for (int i = 0; i < listOfBooking.length; i++) {
      listOfBooking[i].image = AppConstants.imageUrls[i % 4];
    }

    return listOfBooking;
  }
}
