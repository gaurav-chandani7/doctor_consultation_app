import 'dart:math';

import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/view_model/cubit/my_bookings_tab/my_bookings_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingsTab extends StatelessWidget {
  const BookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyBookingsTabCubit()..fetchBookings(),
      child: BlocBuilder<MyBookingsTabCubit, MyBookingsTabState>(
        builder: (context, myBookingsState) {
          return Scaffold(
            appBar: Navigator.canPop(context)
                ? AppBar(
                    title: const Text("My Bookings"),
                  )
                : null,
            body: Builder(builder: (context) {
              if (myBookingsState is MyBookingsTabLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (myBookingsState is MyBookingsTabLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    itemCount: myBookingsState.myBooking!.length,
                    itemBuilder: (context, index) {
                      var item = myBookingsState.myBooking![index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.1),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                color: Colors.black.withOpacity(0.2),
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "${_getFormattedDate(item.appointmentdate!)} - ${_getFormattedTime(item.appointmenttime!)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            const Divider(
                              height: 20,
                              indent: 15,
                              endIndent: 15,
                            ),
                            LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth: min(
                                            constraints.maxWidth * 0.3, 200)),
                                    padding: EdgeInsets.all(min(
                                        (constraints.maxWidth * 0.3 * 0.1),
                                        20)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(myBookingsState
                                              .myBooking![index].image ??
                                          ""),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myBookingsState
                                                .myBooking![index].doctorname ??
                                            "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            AppConstants.location_on_outlined,
                                            color: AppConstants.primaryBlue,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            myBookingsState.myBooking![index]
                                                    .location ??
                                                "",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.menu_book,
                                            color: AppConstants.primaryBlue,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text.rich(TextSpan(
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                            children: [
                                              const TextSpan(
                                                  text: "Booking ID : "),
                                              TextSpan(
                                                  text:
                                                      "#${myBookingsState.myBooking![index].bookingid}",
                                                  style: const TextStyle(
                                                      color: AppConstants
                                                          .primaryBlue,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          )),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              );
                            }),
                            const Divider(
                              height: 20,
                              indent: 15,
                              endIndent: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppConstants.thirdBlue,
                                        ),
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppConstants.primaryBlue,
                                          foregroundColor: Colors.white),
                                      child: const Text("Reshedule"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                  ),
                );
              }
              if (myBookingsState is MyBookingsTabError) {
                return Center(
                  child: Text(myBookingsState.errorMessage ?? ""),
                );
              }
              return const SizedBox();
            }),
          );
        },
      ),
    );
  }

  String _getFormattedDate(String date) {
    DateTime? date1 = DateTime.tryParse(date);
    if (date1 == null) {
      return "";
    }
    return "${AppConstants.monthsThreeLetter[date1.month]} ${date1.day}, ${date1.year}";
  }

  String _getFormattedTime(String time) {
    return time.split(" -").first;
  }
}
