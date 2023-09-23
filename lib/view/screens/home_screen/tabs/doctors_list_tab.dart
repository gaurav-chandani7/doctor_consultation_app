import 'dart:math';

import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/view/screens/doctor_details_screen.dart';
import 'package:doctor_consultation_app/view_model/cubit/doctors_list_tab/doctors_list_tab_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListTab extends StatelessWidget {
  const DoctorsListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorsListTabCubit()..fetchDoctorsList(),
      child: BlocBuilder<DoctorsListTabCubit, DoctorsListTabState>(
        builder: (context, doctorListTabState) {
          if (doctorListTabState is DoctorsListTabLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (doctorListTabState is DoctorsListTabLoaded) {
            return ListView.separated(
              itemBuilder: (context, index) {
                var item = doctorListTabState.doctorList![index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DoctorDetailScreen(
                              doctorDetail: item,
                            )));
                  },
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      children: [
                        Container(
                          width: min(constraints.maxWidth * 0.3, 200),
                          height: min(constraints.maxWidth * 0.3, 200),
                          padding: EdgeInsets.all(
                              min((constraints.maxWidth * 0.3 * 0.1), 20)),
                          child: ClipOval(
                              child: FadeInImage.memoryNetwork(
                            placeholder: AppConstants.kTransparentImage,
                            image:
                                doctorListTabState.doctorList![index].image ??
                                    "",
                            imageErrorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.do_disturb),
                          )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.doctorname ?? "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.speciality ?? ""),
                                Row(
                                  children: [
                                    const Icon(
                                      AppConstants.location_on_rounded,
                                      color: AppConstants.primaryBlue,
                                      size: 18,
                                    ),
                                    Text(
                                      item.location ?? "",
                                      maxLines: 2,
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
                  }),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                indent: 20,
                endIndent: 20,
              ),
              itemCount: doctorListTabState.doctorList!.length,
            );
          }
          if (doctorListTabState is DoctorsListTabError) {
            return Text("Error: ${doctorListTabState.errorMessage}");
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
