class Disease {
  Disease({
    this.id,
    this.title,
    this.desc,
    this.symptoms,
    this.firstAid,
  });

  int? id;
  String? title;
  String? desc;
  String? symptoms;
  String? firstAid;

  factory Disease.fromJson(Map<String?, dynamic> json) => Disease(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        symptoms: json["symptoms"],
        firstAid: json["firstAid"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "symptoms": symptoms,
        "firstAid": firstAid,
      };
}
