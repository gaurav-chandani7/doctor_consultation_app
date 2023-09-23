import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/view_model/bloc/book_appointment/book_appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeChipsWidget extends StatelessWidget {
  const TimeChipsWidget(
      {super.key,
      required this.timeList,
      required this.selectedTimeIndex,
      this.scrollDirection = Axis.horizontal,
      this.onSelectedIndex,
      this.isEditMode = false});
  final List<String> timeList;
  final int? selectedTimeIndex;
  final Axis scrollDirection;
  final ValueChanged<int>? onSelectedIndex;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: scrollDirection,
      child: timeList.isEmpty
          ? const Text("No time slots for selected date")
          : Row(
              children: List.generate(
                  timeList.length,
                  (index) => Padding(
                        padding: index == 0
                            ? EdgeInsets.zero
                            : const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          onSelected: (_) {
                            if (!isEditMode) {
                              BlocProvider.of<BookAppointmentBloc>(context)
                                  .add(SelectTimeEvent(index: index));
                            }
                            if (onSelectedIndex != null) {
                              onSelectedIndex!(index);
                            }
                          },
                          showCheckmark: false,
                          selected: selectedTimeIndex == index,
                          selectedColor: AppConstants.primaryBlue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          label: Column(
                            children: [
                              Text(
                                timeList[index].split(" -").first,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          labelStyle: TextStyle(
                              color: selectedTimeIndex == index
                                  ? Colors.white
                                  : Colors.black),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      )),
            ),
    );
  }
}
