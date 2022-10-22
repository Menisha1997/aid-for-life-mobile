class AppUser {
  AppUser({
    this.fullName,
    this.email,
    this.password,
    this.nic,
    this.phoneNo,
    this.dateOfBirth,
    this.gender,
    this.bloodGroup,
    this.id,
    this.ambulanceId,
    this.hospitalId,
    this.userType,
  });

  String? fullName;
  String? email;
  String? password;
  String? nic;
  String? phoneNo;
  String? dateOfBirth;
  String? gender;
  String? bloodGroup;
  String? userType;
  String? ambulanceId;
  String? hospitalId;

  int? id;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        nic: json["NIC"],
        phoneNo: json["phone_no"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        bloodGroup: json["bloodGroup"],
        id: json["id"],
        ambulanceId: json["ambulanceId"],
        hospitalId: json["hospitalId"],
        userType: json["userType"],
      );

  Map<String, String?> toJson() => {
        "fullName": fullName,
        "email": email,
        "password": password,
        "NIC": nic,
        "phone_no": phoneNo,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "bloodGroup": bloodGroup,
        "id": id.toString(),
      };
}
