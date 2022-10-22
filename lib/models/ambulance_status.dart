class AmbulanceStatus {
  AmbulanceStatus({
    this.ambulanceId,
    this.lat,
    this.lng,
    this.homeLng,
    this.homeLat,
    this.status,
  });

  String? ambulanceId;
  String? lat;
  String? lng;
  String? homeLat;
  String? homeLng;
  String? status;

  factory AmbulanceStatus.fromJson(Map<String, dynamic> json) =>
      AmbulanceStatus(
        ambulanceId: json["ambulanceId"],
        lat: json["lat"],
        lng: json["lng"],
        homeLng: json["homeLng"],
        homeLat: json["homeLat"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "ambulanceId": ambulanceId,
        "lat": lat,
        "lng": lng,
        "homeLng": homeLng,
        "homeLat": homeLat,
        "status": status,
      };
}
