import 'package:flutter/material.dart';

class HomeTabToolbarWidget extends StatelessWidget {
  const HomeTabToolbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Find your Doctor",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(
            height: 2,
          ),
          Text(
            "Book an appointment for Consultation",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
          )
        ],
      );
  }
}