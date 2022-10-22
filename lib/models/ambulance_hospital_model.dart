class AmbulanceHospital {
  AmbulanceHospital({
    this.title,
    this.location,
    this.type,
    this.contactNo,
    this.longitude,
    this.latitude,
    this.id,
  });

  String? title;
  String? location;
  String? type;
  String? contactNo;
  String? longitude;
  String? latitude;
  int? id;

  factory AmbulanceHospital.fromJson(Map<String?, dynamic> json) =>
      AmbulanceHospital(
        title: json["title"],
        location: json["location"],
        type: json["type"],
        contactNo: json["contactNo"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        id: json["id"],
      );

  Map<String?, dynamic> toJson() => {
        "title": title,
        "location": location,
        "type": type,
        "contactNo": contactNo,
        "longitude": longitude,
        "latitude": latitude,
        "id": id,
      };
}
