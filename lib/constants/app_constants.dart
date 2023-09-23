import 'dart:typed_data';

import 'package:flutter/material.dart';

const Color primaryBlue = Color.fromRGBO(42, 100, 242, 1);
const Color secondaryBlue = Color.fromRGBO(219, 231, 249, 1);
const Color thirdBlue = Color.fromRGBO(215, 228, 253, 1);

const int HOME_TAB_INDEX = 0;
const int BOOKINGS_TAB_INDEX = 0;

const String HOME_TAB_LABEL = "Home";
const String BOOKINGS_TAB_LABEL = "Bookings";

const IconData location_on_rounded =
    IconData(0xf884, fontFamily: 'MaterialIcons');
const IconData location_on_outlined =
    IconData(0xf193, fontFamily: 'MaterialIcons');
const IconData reviews = IconData(0xe537, fontFamily: 'MaterialIcons');

const List<String> monthsThreeLetter = [
  "",
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

const List<String> monthsFullWord = [
  "",
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

const List<String> weekdayThreeLetter = [
  "",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat",
  "Sun"
];

const Map<String, IconData> icondataForAppointmentPackages = {
  "Messaging": Icons.message,
  "Voice Call": Icons.phone,
  "Video Call": Icons.videocam,
  "In Person": Icons.person
};

const Map<String, String> subtitleForAppointmentPackages = {
  "Messaging": "Chat with Doctor",
  "Voice Call": "Voice call with doctor",
  "Video Call": "Video call with doctor",
  "In Person": "In Person visit with doctor"
};

const List<String> imageUrls = [
  "https://randomuser.me/api/portraits/men/11.jpg",
  "https://randomuser.me/api/portraits/women/2.jpg",
  "https://randomuser.me/api/portraits/women/8.jpg",
  "https://randomuser.me/api/portraits/men/28.jpg"
];

Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);
