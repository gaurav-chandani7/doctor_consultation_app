import 'package:doctor_consultation_app/view/widgets/bottom_action_button.dart';
import 'package:doctor_consultation_app/view/widgets/day_chips_widget.dart';
import 'package:doctor_consultation_app/view/widgets/doctor_details_screen_widgets.dart';
import 'package:doctor_consultation_app/view/widgets/select_duration_widget.dart';
import 'package:doctor_consultation_app/view/widgets/select_package_widget.dart';
import 'package:doctor_consultation_app/view/widgets/time_chips_widget.dart';
import 'package:doctor_consultation_app/view_model/bloc/book_appointment/book_appointment_bloc.dart';
import 'package:doctor_consultation_app/view_model/bloc/edit_appointment_screen/edit_appointment_bloc.dart';
import 'package:doctor_consultation_app/view_model/cubit/select_package_screen/select_package_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAppointmentScreen extends StatelessWidget {
  const EditAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookAppointmentState = context.read<BookAppointmentBloc>().state;
    final packageOptionsState = context.read<SelectPackageScreenCubit>().state;
    return BlocProvider(
      create: (context) =>
          EditAppointmentBloc(preEditingState: bookAppointmentState),
      child: BlocBuilder<EditAppointmentBloc, EditAppointmentState>(
        builder: (context, editAppointmentState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Edit Appointment"),
            ),
            body: ClipRRect(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoctorDetailsTopWidget(
                              doctorDetail:
                                  bookAppointmentState.selectedDoctor),
                          const Text(
                            "Day",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DayChipsWidget(
                            dayList: bookAppointmentState
                                .selectedDoctor.availability!.keys
                                .toList(),
                            selectedDayIndex:
                                editAppointmentState.selectedDayIndex,
                            isEditMode: true,
                            onSelectedIndex: (value) =>
                                BlocProvider.of<EditAppointmentBloc>(context)
                                    .add(EditDayOfAppointmentEvent(
                                        dayIndex: value)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          editAppointmentState.selectedDayIndex != null
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
                                      timeList: bookAppointmentState
                                          .selectedDoctor.availability!.values
                                          .elementAt(editAppointmentState
                                              .selectedDayIndex!),
                                      selectedTimeIndex: editAppointmentState
                                          .selectedTimeIndex,
                                      isEditMode: true,
                                      onSelectedIndex: (value) =>
                                          BlocProvider.of<EditAppointmentBloc>(
                                                  context)
                                              .add(EditTimeOfAppointmentEvent(
                                                  timeIndex: value)),
                                    )
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 20,
                          ),
                          SelectDurationWidget(
                            durationList: packageOptionsState
                                .appointmentOptions!.duration ?? [],
                            initialSelection:
                                bookAppointmentState.selectedDuration ?? "",
                            isEditMode: true,
                            onSelectedCallback: (val) => val != null
                                ? BlocProvider.of<EditAppointmentBloc>(context)
                                    .add(EditDurationOfAppointmentEvent(
                                        duration: val))
                                : null,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SelectPackageWidget(
                            packageList:
                                packageOptionsState.appointmentOptions!.package ?? [],
                            isEditMode: true,
                            onSelectedCallback: (val) {
                              BlocProvider.of<EditAppointmentBloc>(context).add(
                                  EditPackageOfAppointmentEvent(package: val));
                            },
                            selectedValue: editAppointmentState.selectedPackage,
                          ),
                          const SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                  BottomActionButton(
                    buttonText: "Save",
                    onPressed: (editAppointmentState.selectedDayIndex != null &&
                            editAppointmentState.selectedTimeIndex != null &&
                            editAppointmentState.selectedDuration != null &&
                            editAppointmentState.selectedPackage != null)
                        ? () {
                            BlocProvider.of<BookAppointmentBloc>(context).add(
                                EditCompleteAppointmentEvent(
                                    dayIndex:
                                        editAppointmentState.selectedDayIndex,
                                    timeIndex:
                                        editAppointmentState.selectedTimeIndex,
                                    duration:
                                        editAppointmentState.selectedDuration,
                                    package:
                                        editAppointmentState.selectedPackage));
                            Navigator.of(context).pop(true);
                          }
                        : null,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
