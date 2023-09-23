import 'package:doctor_consultation_app/constants/app_constants.dart'
    as AppConstants;
import 'package:doctor_consultation_app/view/screens/home_screen/tabs/bookings_tab.dart';
import 'package:doctor_consultation_app/view/screens/home_screen/tabs/doctors_list_tab.dart';
import 'package:doctor_consultation_app/view/widgets/home_tab_toolbar.dart';
import 'package:doctor_consultation_app/view_model/cubit/home_screen/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = const [DoctorsListTab(), BookingsTab()];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit(),
      child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, homeScreenState) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: homeScreenState.activeTab == AppConstants.HOME_TAB_INDEX
                  ? const HomeTabToolbarWidget()
                  : null,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: AppConstants.HOME_TAB_LABEL),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt),
                    label: AppConstants.BOOKINGS_TAB_LABEL)
              ],
              onTap: (value) {
                BlocProvider.of<HomeScreenCubit>(context)
                    .bottomNavbarItemOnTap(value: value);
              },
              currentIndex: homeScreenState.activeTab,
            ),
            body: IndexedStack(
              index: homeScreenState.activeTab,
              children: _tabs,
            ),
          );
        },
      ),
    );
  }
}
