class StudentVideoRel {
  int? svId;
  int? studentId;
  int? videoId;
  String? comment;
  String? commentDate;

  StudentVideoRel({
    this.svId,
    this.studentId,
    this.videoId,
    this.comment,
    this.commentDate,
  });

  factory StudentVideoRel.fromJson(Map<String, dynamic> json) {
    return StudentVideoRel(
      svId: json['sv_id'],
      studentId: json['student_id'],
      videoId: json['video_id'],
      comment: json['comment'],
      commentDate: json['comment_date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'sv_id': svId,
        'student_id': studentId,
        'video_id': videoId,
        'comment': comment,
        'comment_date': commentDate,
      };
}
