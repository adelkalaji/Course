import 'package:flutter_application_3/config/config.dart';

class Course {
  int? courseId;
  String? courseName;
  String? courseDesc;
  int? courseHours;
  int? courseStatus;
  String? courseImage;
  int? teacherId;
  String? teacherName;
  int? total;
  Course(
      {this.courseId,
      this.courseName,
      this.courseDesc,
      this.courseHours,
      this.courseStatus,
      this.courseImage,
      this.teacherId,
      this.teacherName,
      this.total});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['course_id'],
      courseName: json['course_name'],
      courseDesc: json['course_desc'],
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
        'course_hours': courseHours,
        'course_status': courseStatus,
        'course_image': courseImage,
        'teacher_id': teacherId,
        'teacher_name': teacherName,
        'total': total
      };
}
