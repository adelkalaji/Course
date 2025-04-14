import 'package:flutter_application_3/config/config.dart';

class FavoriteCourse {
  int? courseId;
  String? courseName;
  String? courseDesc;
  String? courseCreateAt;
  int? courseHours;
  int? courseStatus;
  String? courseImage;
  int? specialityId;
  int? teacherId;

  int? eve;
  String? teacherName;
  int? total;
  FavoriteCourse(
      {this.courseId,
      this.courseName,
      this.courseDesc,
      this.courseCreateAt,
      this.courseHours,
      this.courseStatus,
      this.courseImage,
      this.specialityId,
      this.teacherId,
      this.eve,
      this.teacherName,
      this.total});

  factory FavoriteCourse.fromJson(Map<String, dynamic> json) {
    return FavoriteCourse(
      courseId: json['course_id'],
      courseName: json['course_name'],
      courseDesc: json['course_desc'],
      courseCreateAt: json['course_create_at'],
      courseHours: json['course_hours'],
      courseStatus: json['course_status'],
      courseImage: Config.image + json['course_image'],
      specialityId: json['speciality_id'],
      teacherId: json['teacher_id'],
      eve: json['eve'],
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
        'speciality_id': specialityId,
        'teacher_id': teacherId,
        'eve': eve,
        'teacher_name': teacherName,
        'total': total
      };
}
