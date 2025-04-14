class Speciality {
  String? specialityId;
  String? specialityName;
  String? specialityImg;

  Speciality({
    this.specialityId,
    this.specialityName,
    this.specialityImg,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) {
    return Speciality(
      specialityId: json['speciality_id'],
      specialityName: json['speciality_name'],
      specialityImg: json['speciality_img'],
    );
  }

  Map<String, dynamic> toJson() => {
        'speciality_id': specialityId,
        'speciality_name': specialityName,
        'speciality_img': specialityImg,
      };
}
