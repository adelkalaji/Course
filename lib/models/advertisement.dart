class Advertisement {
  String? imgId;
  String? imgPath;

  Advertisement({
    this.imgId,
    this.imgPath,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      imgId: json['img_id'],
      imgPath: json['img_path'],
    );
  }

  Map<String, dynamic> toJson() => {
        'img_id': imgId,
        'img_path': imgPath,
      };
}
