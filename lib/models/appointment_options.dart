class AppointmentOptions {
  List<String>? duration;
  List<String>? package;
  AppointmentOptions({
    required this.duration,
    required this.package,
  });

  AppointmentOptions.fromJson(Map<String, dynamic> json) {
    duration = List<String>.from(json['duration']);
    package = List<String>.from(json['package']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['duration'] = duration;
    data['package'] = package;
    return data;
  }

  @override
  String toString() =>
      'AppointmentOptions(duration: $duration, package: $package)';
}
