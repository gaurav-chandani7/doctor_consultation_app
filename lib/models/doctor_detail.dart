class DoctorDetail {
  String? doctorname;
  String? image;
  String? speciality;
  String? location;
  int? patientsserved;
  int? yearsofexperience;
  double? rating;
  int? numberofreviews;
  Map<DateTime, List<String>>? availability;

  DoctorDetail(
      {this.doctorname,
      this.image,
      this.speciality,
      this.location,
      this.patientsserved,
      this.yearsofexperience,
      this.rating,
      this.numberofreviews,
      this.availability});

  DoctorDetail.fromJson(Map<String, dynamic> json) {
    doctorname = json['doctor_name'];
    image = json['image'];
    speciality = json['speciality'];
    location = json['location'];
    patientsserved = json['patients_served'];
    yearsofexperience = json['years_of_experience'];
    rating = json['rating'];
    numberofreviews = json['number_of_reviews'];
    availability = json['availability'] != null
        ? {
            for (var element in Map.from(json['availability']).entries)
              DateTime.tryParse(element.key) ?? DateTime.now():
                  List.from(element.value)
          }
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['doctor_name'] = doctorname;
    data['image'] = image;
    data['speciality'] = speciality;
    data['location'] = location;
    data['patients_served'] = patientsserved;
    data['years_of_experience'] = yearsofexperience;
    data['rating'] = rating;
    data['number_of_reviews'] = numberofreviews;
    data['availability'] = availability!.toString();
    return data;
  }
}
