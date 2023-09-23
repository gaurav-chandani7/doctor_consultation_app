class BookingConfirmation {
  String? doctorname;
  String? appointmentdate;
  String? appointmenttime;
  String? location;
  String? appointmentpackage;

  BookingConfirmation(
      {this.doctorname,
      this.appointmentdate,
      this.appointmenttime,
      this.location,
      this.appointmentpackage});

  BookingConfirmation.fromJson(Map<String, dynamic> json) {
    doctorname = json['doctor_name'];
    appointmentdate = json['appointment_date'];
    appointmenttime = json['appointment_time'];
    location = json['location'];
    appointmentpackage = json['appointment_package'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['doctor_name'] = doctorname;
    data['appointment_date'] = appointmentdate;
    data['appointment_time'] = appointmenttime;
    data['location'] = location;
    data['appointment_package'] = appointmentpackage;
    return data;
  }
}
