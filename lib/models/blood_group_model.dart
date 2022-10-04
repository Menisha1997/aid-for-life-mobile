class BloodGroup {
  BloodGroup({
    this.id,
    this.title,
    this.desc,
  });

  int? id;
  String? title;
  String? desc;

  factory BloodGroup.fromJson(Map<String, dynamic> json) => BloodGroup(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
      };
}
