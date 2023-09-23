import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/view/screens/booking_confirmation_screen.dart';
import 'package:doctor_consultation_app/view/screens/edit_appointment_screen.dart';
import 'package:doctor_consultation_app/view/widgets/bottom_action_button.dart';
import 'package:doctor_consultation_app/view/widgets/doctor_details_screen_widgets.dart';
import 'package:doctor_consultation_app/view_model/bloc/book_appointment/book_appointment_bloc.dart';
import 'package:doctor_consultation_app/view_model/cubit/select_package_screen/select_package_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewBookingScreen extends StatefulWidget {
  const ReviewBookingScreen({super.key});

  @override
  State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends State<ReviewBookingScreen> {
  bool editFlag = false;
  @override
  Widget build(BuildContext context) {
    final bookAppointmentBlocState = context.read<BookAppointmentBloc>().state;
    final selectedDoctor = bookAppointmentBlocState.selectedDoctor;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(editFlag);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Review Summary"),
          actions: [
            TextButton(
                onPressed: () async {
                  final bookAppointmentBloc =
                      context.read<BookAppointmentBloc>();
                  final selectPackageOptionsBloc =
                      BlocProvider.of<SelectPackageScreenCubit>(context);
                  var res = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: bookAppointmentBloc,
                              ),
                              BlocProvider.value(
                                value: selectPackageOptionsBloc,
                              ),
                            ],
                            child: const EditAppointmentScreen(),
                          )));
                  if (res == true) {
                    editFlag = true;
                    setState(() {});
                  }
                },
                child: const Text("Edit"))
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  DoctorDetailsTopWidget(doctorDetail: selectedDoctor),
                  const Divider(
                    height: 30,
                  ),
                  Column(
                    children: [
                      SummaryScreenItem(
                        leftText: "Date & Hour",
                        rightText:
                            _getDayAndTimeInString(bookAppointmentBlocState),
                      ),
                      SummaryScreenItem(
                        leftText: "Package",
                        rightText:
                            bookAppointmentBlocState.selectedPackage ?? "",
                      ),
                      SummaryScreenItem(
                        leftText: "Duration",
                        rightText:
                            bookAppointmentBlocState.selectedDuration ?? "",
                      ),
                      const SummaryScreenItem(
                        leftText: "Booking for",
                        rightText: "Self",
                      )
                    ],
                  )
                ],
              ),
            ),
            BottomActionButton(
              buttonText: "Confirm",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BookingConfirmationScreen()));
              },
            )
          ],
        ),
      ),
    );
  }

  String _getDayAndTimeInString(BookAppointmentState bookAppointmentBlocState) {
    int dayIndex = bookAppointmentBlocState.selectedDayIndex!;
    DateTime day = bookAppointmentBlocState.selectedDoctor.availability!.keys
        .elementAt(dayIndex);
    int timeIndex = bookAppointmentBlocState.selectedTimeIndex!;
    String startTime = bookAppointmentBlocState
        .selectedDoctor.availability!.values
        .elementAt(dayIndex)[timeIndex]
        .split(" -")
        .first;
    String dayInString =
        "${AppConstants.monthsFullWord[day.month]} ${day.day}, ${day.year} | $startTime";
    return dayInString;
  }
}

class SummaryScreenItem extends StatelessWidget {
  const SummaryScreenItem({
    super.key,
    required this.leftText,
    required this.rightText,
  });
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w700),
          ),
          Text(
            rightText,
            style: const TextStyle(fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
