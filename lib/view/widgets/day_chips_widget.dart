import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/view_model/bloc/book_appointment/book_appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayChipsWidget extends StatelessWidget {
  const DayChipsWidget(
      {super.key,
      required this.dayList,
      this.selectedDayIndex,
      this.scrollDirection = Axis.horizontal,
      this.onSelectedIndex,
      this.isEditMode = false});
  final List<DateTime> dayList;
  final int? selectedDayIndex;
  final Axis scrollDirection;
  final ValueChanged<int>? onSelectedIndex;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: scrollDirection,
      child: Row(
        children: List.generate(
            dayList.length,
            (index) => Padding(
                  padding: index == 0
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    onSelected: (_) {
                      if (!isEditMode) {
                        BlocProvider.of<BookAppointmentBloc>(context)
                            .add(SelectDayEvent(index: index));
                      }
                      if (onSelectedIndex != null) {
                        onSelectedIndex!(index);
                      }
                    },
                    showCheckmark: false,
                    selected: selectedDayIndex == index,
                    selectedColor: AppConstants.primaryBlue,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    label: Column(
                      children: [
                        Text(
                            AppConstants
                                .weekdayThreeLetter[dayList[index].weekday],
                            style:
                                const TextStyle(fontWeight: FontWeight.w300)),
                        Text(
                          "${dayList[index].day} ${AppConstants.monthsThreeLetter[dayList[index].month]}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    labelStyle: TextStyle(
                        color: selectedDayIndex == index
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
