import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/models/doctor_detail.dart';
import 'package:doctor_consultation_app/view/screens/select_package_screen.dart';
import 'package:doctor_consultation_app/view/widgets/bottom_action_button.dart';
import 'package:doctor_consultation_app/view/widgets/day_chips_widget.dart';
import 'package:doctor_consultation_app/view/widgets/doctor_details_screen_widgets.dart';
import 'package:doctor_consultation_app/view/widgets/time_chips_widget.dart';
import 'package:doctor_consultation_app/view_model/bloc/book_appointment/book_appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({super.key, required this.doctorDetail});
  final DoctorDetail doctorDetail;

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookAppointmentBloc(selectedDoctor: widget.doctorDetail),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book Appointment"),
        ),
        body: ClipRRect(
          child: BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
            builder: (context, bookAppointmentState) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoctorDetailsTopWidget(
                              doctorDetail: widget.doctorDetail),
                          const Divider(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DoctorNumericDataItem(
                                icon: Icons.people,
                                title:
                                    "${bookAppointmentState.selectedDoctor.patientsserved}+",
                                subtitle: "Patients",
                              ),
                              DoctorNumericDataItem(
                                icon: Icons.card_travel,
                                title:
                                    "${bookAppointmentState.selectedDoctor.yearsofexperience}+",
                                subtitle: "Years Exp.",
                              ),
                              DoctorNumericDataItem(
                                icon: Icons.star,
                                title:
                                    "${bookAppointmentState.selectedDoctor.rating}+",
                                subtitle: "Rating",
                              ),
                              DoctorNumericDataItem(
                                icon: AppConstants.reviews,
                                title:
                                    "${bookAppointmentState.selectedDoctor.numberofreviews}",
                                subtitle: "Review",
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text("BOOK APPOINTMENT"),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Day",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DayChipsWidget(
                            dayList:
                                widget.doctorDetail.availability!.keys.toList(),
                            selectedDayIndex:
                                bookAppointmentState.selectedDayIndex,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          bookAppointmentState.selectedDayIndex != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TimeChipsWidget(
                                      timeList: widget
                                          .doctorDetail.availability!.values
                                          .elementAt(bookAppointmentState
                                              .selectedDayIndex!),
                                      selectedTimeIndex: bookAppointmentState
                                          .selectedTimeIndex,
                                    )
                                  ],
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                  BottomActionButton(
                    onPressed: (bookAppointmentState.selectedDayIndex != null &&
                            bookAppointmentState.selectedTimeIndex != null)
                        ? () async {
                            final bookAppointmentBloc =
                                BlocProvider.of<BookAppointmentBloc>(context);
                            var res = await Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                          value: bookAppointmentBloc,
                                          child: const SelectPackageScreen(),
                                        )));
                            if (res == true) {
                              //Page was edited, refresh UI
                              setState(() {});
                            }
                          }
                        : null,
                    buttonText: "Make Appointment",
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
