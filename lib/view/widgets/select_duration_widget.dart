import 'package:doctor_consultation_app/constants/app_constants.dart' as AppConstants;
import 'package:doctor_consultation_app/view_model/bloc/book_appointment/book_appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectDurationWidget extends StatelessWidget {
  const SelectDurationWidget(
      {super.key,
      required this.durationList,
      this.onSelectedCallback,
      this.isEditMode = false,
      required this.initialSelection});
  final List<String> durationList;
  final Function(String?)? onSelectedCallback;
  final bool isEditMode;
  final String initialSelection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Duration",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return DropdownMenu(
              dropdownMenuEntries:
                  _getDropdownForDuration(duration: durationList),
              onSelected: (value) {
                if (!isEditMode) {
                  BlocProvider.of<BookAppointmentBloc>(context)
                      .add(SelectDurationEvent(duration: value ?? ""));
                }
                if (onSelectedCallback != null) {
                  onSelectedCallback!(value);
                }
              },
              initialSelection: initialSelection,
              width: constraints.maxWidth,
              leadingIcon: const Icon(
                Icons.watch_later,
                color: AppConstants.primaryBlue,
                size: 28,
              ),
              selectedTrailingIcon: const Icon(
                Icons.keyboard_arrow_up,
                color: AppConstants.primaryBlue,
                size: 28,
              ),
              trailingIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppConstants.primaryBlue,
                size: 28,
              ),
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            );
          }),
        ),
      ],
    );
  }

  List<DropdownMenuEntry<String>> _getDropdownForDuration(
      {required List<String> duration}) {
    return List<DropdownMenuEntry<String>>.generate(
        duration.length,
        (index) => DropdownMenuEntry(
            value: duration[index],
            label: "${duration[index].split(" ").first} minutes"));
  }
}