import 'package:doctor_consultation_app/constants/app_constants.dart' as AppConstants;
import 'package:doctor_consultation_app/view/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DoctorConsultationApp());
}

class DoctorConsultationApp extends StatelessWidget {
  const DoctorConsultationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: MaterialApp(
        title: 'Doctor Consultation App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.primaryBlue),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 15))),
        home: const HomeScreen(),
      ),
    );
  }
}
