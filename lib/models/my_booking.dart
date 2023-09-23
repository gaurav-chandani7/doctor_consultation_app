class MyBooking {
  String? bookingid;
  String? doctorname;
  String? location;
  String? appointmentdate;
  String? appointmenttime;
  String? image;

  MyBooking(
      {this.bookingid,
      this.doctorname,
      this.location,
      this.appointmentdate,
      this.appointmenttime,
      this.image});

  MyBooking.fromJson(Map<String, dynamic> json) {
    bookingid = json['booking_id'];
    doctorname = json['doctor_name'];
    location = json['location'];
    appointmentdate = json['appointment_date'];
    appointmenttime = json['appointment_time'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['booking_id'] = bookingid;
    data['doctor_name'] = doctorname;
    data['location'] = location;
    data['appointment_date'] = appointmentdate;
    data['appointment_time'] = appointmenttime;
    data['image'] = image;
    return data;
  }
}
