import 'package:bloc/bloc.dart';
import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit()
      : super(const HomeScreenInitial(activeTab: AppConstants.HOME_TAB_INDEX));

  bottomNavbarItemOnTap({required int value}) {
    emit(HomeScreenInitial(activeTab: value));
  }
}
