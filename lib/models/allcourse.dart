import 'package:flutter_application_3/config/config.dart';

class AllCourse {
  int? courseId;
  String? courseName;
  String? courseDesc;
  String? courseCreateAt;
  int? courseHours;
  int? courseStatus;
  String? courseImage;
  int? teacherId;
  String? teacherName;
  int? total;
  AllCourse(
      {this.courseId,
      this.courseName,
      this.courseDesc,
      this.courseCreateAt,
      this.courseHours,
      this.courseStatus,
      this.courseImage,
      this.teacherId,
      this.teacherName,
      this.total});

  factory AllCourse.fromJson(Map<String, dynamic> json) {
    return AllCourse(
      courseId: json['course_id'],
      courseName: json['course_name'],
      courseDesc: json['course_desc'],
      courseCreateAt: json['course_create_at'],
      courseHours: json['course_hours'],
      courseStatus: json['course_status'],
      courseImage: Config.image + json['course_image'],
      teacherId: json['teacher_id'],
      teacherName: json['teacher_name'],
      total: json['total'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': courseId,
        'course_name': courseName,
        'course_desc': courseDesc,
        'course_create_at': courseCreateAt,
        'course_hours': courseHours,
        'course_status': courseStatus,
        'course_image': courseImage,
        'teacher_id': teacherId,
        'teacher_name': teacherName,
        'total': total
      };
}
