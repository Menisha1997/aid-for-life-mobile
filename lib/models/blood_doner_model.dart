class BloodDoner {
  BloodDoner({
    required this.id,
    required this.name,
    required this.blooaGroup,
    required this.contectNumber,
  });

  int id;
  String name;
  String blooaGroup;
  String contectNumber;

  factory BloodDoner.fromJson(Map<String, dynamic> json) => BloodDoner(
        id: json["id"],
        name: json["name"],
        blooaGroup: json["BlooaGroup"],
        contectNumber: json["ContectNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "BlooaGroup": blooaGroup,
        "ContectNumber": contectNumber,
      };
}
