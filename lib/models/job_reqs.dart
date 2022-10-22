class JobRequest {
  JobRequest({
    this.ambulanceId,
    this.lat,
    this.lng,
    this.status,
    this.notes,
    this.caseType,
    this.requestUserId,
    this.userName,
    this.phone,
    this.dateOn,
  });

  int? ambulanceId;
  String? lat;
  String? lng;
  String? status;
  String? notes;

  String? caseType;
  int? requestUserId;
  String? userName;
  String? phone;
  String? dateOn;

  factory JobRequest.fromJson(Map<String, dynamic> json) => JobRequest(
        ambulanceId: json["ambulanceId"],
        lat: json["lat"],
        lng: json["lng"],
        status: json["status"],
        notes: json["notes"],
        caseType: json["caseType"],
        requestUserId: json["requestUserId"],
        userName: json["userName"],
        phone: json["phone"],
        dateOn: json["dateOn"],
      );

  Map<String, dynamic> toJson() => {
        "ambulanceId": ambulanceId,
        "lat": lat,
        "lng": lng,
        "status": status,
        "notes": notes,
        "caseType": caseType,
        "requestUserId": requestUserId,
        "userName": userName,
        "phone": phone,
        "dateOn": dateOn,
      };
}
