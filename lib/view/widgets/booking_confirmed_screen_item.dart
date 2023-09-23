import 'package:doctor_consultation_app/constants/app_constants.dart' as AppConstants;
import 'package:flutter/material.dart';

class BookingConfirmedDetailItem extends StatelessWidget {
  const BookingConfirmedDetailItem({
    super.key,
    required this.iconData,
    required this.text,
  });
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: AppConstants.primaryBlue,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}