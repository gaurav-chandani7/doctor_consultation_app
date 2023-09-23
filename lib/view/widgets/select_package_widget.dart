import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/view_model/bloc/book_appointment/book_appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPackageWidget extends StatelessWidget {
  const SelectPackageWidget(
      {super.key,
      required this.packageList,
      this.isEditMode = false,
      this.onSelectedCallback,
      required this.selectedValue});
  final List<String> packageList;
  final bool isEditMode;
  final Function(String)? onSelectedCallback;
  final String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Package",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: _getPackagesForAppointment(
              packages: packageList, selectedValue: selectedValue),
        )
      ],
    );
  }

  List<Widget> _getPackagesForAppointment(
      {required List<String> packages, String? selectedValue}) {
    return List.generate(
        packages.length,
        (index) => SelectPackageItem(
              isEditMode: isEditMode,
              iconData: AppConstants
                      .icondataForAppointmentPackages[packages[index]] ??
                  Icons.do_not_disturb_alt_sharp,
              title: packages[index],
              selectedValue: selectedValue,
              subtitle: AppConstants
                      .subtitleForAppointmentPackages[packages[index]] ??
                  "",
              onSelectedCallback: (_) {
                if (onSelectedCallback != null) {
                  onSelectedCallback!(_);
                }
              },
            ));
  }
}

//New Widget Below

class SelectPackageItem extends StatelessWidget {
  const SelectPackageItem(
      {super.key,
      required this.iconData,
      required this.title,
      this.selectedValue,
      required this.subtitle,
      required this.isEditMode,
      required this.onSelectedCallback});
  final IconData iconData;
  final String title;
  final String? selectedValue;
  final String subtitle;
  final bool isEditMode;
  final Function(String) onSelectedCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          if (!isEditMode) {
            BlocProvider.of<BookAppointmentBloc>(context)
                .add(SelectPackageEvent(package: title));
          }
          onSelectedCallback(title);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
              ]),
          child: Row(
            children: [
              ClipOval(
                child: Container(
                    color: AppConstants.secondaryBlue,
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      iconData,
                      color: AppConstants.primaryBlue,
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Radio(
                    value: title,
                    groupValue: selectedValue,
                    onChanged: (val) {
                      if (val != null && !isEditMode) {
                        BlocProvider.of<BookAppointmentBloc>(context)
                            .add(SelectPackageEvent(package: val));
                      }
                      if (val != null) {
                        onSelectedCallback(val);
                      }
                    },
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
