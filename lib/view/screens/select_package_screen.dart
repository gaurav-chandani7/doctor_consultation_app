import 'package:doctor_consultation_app/view/screens/review_booking_screen.dart';
import 'package:doctor_consultation_app/view/widgets/bottom_action_button.dart';
import 'package:doctor_consultation_app/view/widgets/select_duration_widget.dart';
import 'package:doctor_consultation_app/view/widgets/select_package_widget.dart';
import 'package:doctor_consultation_app/view_model/bloc/book_appointment/book_appointment_bloc.dart';
import 'package:doctor_consultation_app/view_model/cubit/select_package_screen/select_package_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPackageScreen extends StatelessWidget {
  const SelectPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool editFlag = false;
    return BlocProvider(
      create: (context) =>
          SelectPackageScreenCubit()..fetchAppointmentOptions(),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(editFlag);
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Select Package"),
            ),
            body:
                BlocBuilder<SelectPackageScreenCubit, SelectPackageScreenState>(
              builder: (context, selectPackageScreenState) {
                if (selectPackageScreenState is SelectPackageScreenLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (selectPackageScreenState is SelectPackageScreenLoaded) {
                  //Set first entry as default
                  if (context
                          .read<BookAppointmentBloc>()
                          .state
                          .selectedDuration ==
                      null) {
                    BlocProvider.of<BookAppointmentBloc>(context).add(
                        SelectDurationEvent(
                            duration: selectPackageScreenState
                                .appointmentOptions!.duration!.first));
                  }
                  return BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
                    builder: (context, bookAppointmentState) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectDurationWidget(
                                    durationList: selectPackageScreenState
                                            .appointmentOptions!.duration ??
                                        [],
                                    initialSelection: selectPackageScreenState
                                        .appointmentOptions!.duration!.first,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SelectPackageWidget(
                                    packageList: selectPackageScreenState
                                            .appointmentOptions!.package ??
                                        [],
                                    selectedValue: context
                                        .read<BookAppointmentBloc>()
                                        .state
                                        .selectedPackage,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BottomActionButton(
                            buttonText: "Next",
                            onPressed: (bookAppointmentState.selectedDuration !=
                                        null &&
                                    bookAppointmentState.selectedPackage !=
                                        null)
                                ? () async {
                                    final bookAppointmentBloc =
                                        BlocProvider.of<BookAppointmentBloc>(
                                            context);
                                    final selectPackageOptionsBloc =
                                        BlocProvider.of<
                                            SelectPackageScreenCubit>(context);
                                    var res = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider.value(
                                                      value:
                                                          bookAppointmentBloc,
                                                    ),
                                                    BlocProvider.value(
                                                      value:
                                                          selectPackageOptionsBloc,
                                                    ),
                                                  ],
                                                  child:
                                                      const ReviewBookingScreen(),
                                                )));
                                    if (res == true) {
                                      // Page was edited, so refresh UI
                                      editFlag = true;
                                      selectPackageOptionsBloc.refreshScreen();
                                    }
                                  }
                                : null,
                          )
                        ],
                      );
                    },
                  );
                }
                if (selectPackageScreenState is SelectPackageScreenError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: Text(selectPackageScreenState.errorMessage ?? ""),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )),
      ),
    );
  }
}
