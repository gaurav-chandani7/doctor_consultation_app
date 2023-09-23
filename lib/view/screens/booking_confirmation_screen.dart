import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/other/horizantal_dashed_line_paint.dart';
import 'package:doctor_consultation_app/view/screens/home_screen/tabs/bookings_tab.dart';
import 'package:doctor_consultation_app/view/widgets/booking_confirmed_screen_item.dart';
import 'package:doctor_consultation_app/view/widgets/bottom_action_button.dart';
import 'package:doctor_consultation_app/view_model/cubit/booking_confirmation_screen/booking_confirmation_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingConfirmationScreenCubit()..fetchBookingConfirmation(),
      child: BlocBuilder<BookingConfirmationScreenCubit,
          BookingConfirmationScreenState>(
        builder: (context, bookingConfirmationScreenState) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).popUntil((route) => route.isFirst);
              return false;
            },
            child: Scaffold(
                appBar: bookingConfirmationScreenState
                        is BookingConfirmationScreenLoaded
                    ? AppBar(
                        title: const Text("Confirmation"),
                      )
                    : null,
                body: Builder(
                  builder: (context) {
                    if (bookingConfirmationScreenState
                        is BookingConfirmationScreenLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (bookingConfirmationScreenState
                        is BookingConfirmationScreenLoaded) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Center(
                                    child: ClipOval(
                                        child: Container(
                                      padding: const EdgeInsets.all(15),
                                      color: AppConstants.primaryBlue,
                                      child: const Icon(
                                        Icons.check,
                                        size: 80,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Appointment confirmed!",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "You have successfully booked appointment with",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    bookingConfirmationScreenState
                                            .bookingConfirmation!.doctorname ??
                                        "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  LayoutBuilder(
                                      builder: (context, constraints) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SizedBox(
                                        width: constraints.maxWidth,
                                        child: CustomPaint(
                                          painter: HorizontalDashedLinePaint(),
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    children: [
                                      const BookingConfirmedDetailItem(
                                        iconData: Icons.person_rounded,
                                        text: "Esther Howard",
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: BookingConfirmedDetailItem(
                                              iconData: Icons.calendar_month,
                                              text: _getFormattedDate(
                                                  bookingConfirmationScreenState
                                                          .bookingConfirmation!
                                                          .appointmentdate ??
                                                      ""),
                                            ),
                                          ),
                                          Expanded(
                                            child: BookingConfirmedDetailItem(
                                              iconData: Icons.timer,
                                              text:
                                                  bookingConfirmationScreenState
                                                      .bookingConfirmation!
                                                      .appointmenttime!
                                                      .split(" -")
                                                      .first,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          BottomActionButton(
                            buttonText: "View Appointments",
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const BookingsTab()));
                            },
                            textButtonText: "Book Another",
                            textButtonOnPressed: () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                          )
                        ],
                      );
                    }
                    if (bookingConfirmationScreenState
                        is BookingConfirmationScreenError) {
                      return Center(
                        child: Text(
                            bookingConfirmationScreenState.errorMessage ?? ""),
                      );
                    }
                    return const SizedBox();
                  },
                )),
          );
        },
      ),
    );
  }

  String _getFormattedDate(String date) {
    DateTime? date1 = DateTime.tryParse(date);
    if (date1 == null) {
      return "";
    }
    return "${date1.day} ${AppConstants.monthsThreeLetter[date1.month]}, ${date1.year}";
  }
}
