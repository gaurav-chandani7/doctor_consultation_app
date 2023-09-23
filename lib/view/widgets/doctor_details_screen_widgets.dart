import 'dart:math';

import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/models/doctor_detail.dart';
import 'package:doctor_consultation_app/other/wavy_circle_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorDetailsTopWidget extends StatelessWidget {
  const DoctorDetailsTopWidget({
    super.key,
    required this.doctorDetail,
  });

  final DoctorDetail doctorDetail;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Container(
            constraints:
                BoxConstraints(maxWidth: min(constraints.maxWidth * 0.35, 200)),
            padding:
                EdgeInsets.all(min((constraints.maxWidth * 0.35 * 0.1), 20)),
            child: Stack(
              children: [
                ClipOval(
                  child: Image.network(
                    doctorDetail.image ?? "",
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: ClipPath(
                    clipper: WavyCircleClipper(20),
                    child: Container(
                        color: AppConstants.primaryBlue,
                        height: 30,
                        width: 30,
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        )),
                  ),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctorDetail.doctorname ?? "",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctorDetail.speciality ?? ""),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        AppConstants.location_on_rounded,
                        color: AppConstants.primaryBlue,
                        size: 18,
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth * 0.5),
                        child: Text(
                          doctorDetail.location ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      const Icon(
                        CupertinoIcons.map_fill,
                        color: AppConstants.primaryBlue,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      );
    });
  }
}

class DoctorNumericDataItem extends StatelessWidget {
  const DoctorNumericDataItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Container(
              color: AppConstants.secondaryBlue,
              padding: const EdgeInsets.all(15),
              child: Icon(
                icon,
                color: AppConstants.primaryBlue,
              )),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: AppConstants.primaryBlue,
              fontWeight: FontWeight.w900,
              fontSize: 16),
        ),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13),
        )
      ],
    );
  }
}
