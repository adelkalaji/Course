import 'package:flutter_application_3/config/config.dart';

class Teacher {
  int? teacherId;
  String? teacherName;
  String? teacherEmail;
  String? teacherMob;
  String? teacherImage;
  String? teacherDesc;
  String? teacherJoin;
  int? teacherStatus;
  int? specialityId;
  int? userId;
  String? teacherWhatsapp;

  Teacher({
    this.teacherId,
    this.teacherName,
    this.teacherEmail,
    this.teacherMob,
    this.teacherImage,
    this.teacherDesc,
    this.teacherJoin,
    this.teacherStatus,
    this.specialityId,
    this.userId,
    this.teacherWhatsapp,
  });
//Teacher_id as id , Teacher_name, Teacher_email, Teacher_mob, Teacher_image, Teacher_desc, speciality_id, Teacher
//_join,teacher_status, User_id FROM teacher"
  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      teacherId: json['id'],
      teacherName: json['Teacher_name'],
      teacherEmail: json['Teacher_email'],
      teacherMob: json['Teacher_mob'],
      teacherImage: Config.image + json['Teacher_image'],
      teacherDesc: json['Teacher_desc'],
      teacherJoin: json['Teacher_join'],
      teacherStatus: json['Teacher_status'],
      specialityId: json['speciality_id'],
      userId: json['User_id'],
      teacherWhatsapp: json['teacher_whatsapp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'teacher_id': teacherId,
        'teacher_name': teacherName,
        'teacher_email': teacherEmail,
        'teacher_mob': teacherMob,
        'teacher_image': teacherImage,
        'teacher_desc': teacherDesc,
        'teacher_join': teacherJoin,
        'Teacher_status': teacherStatus,
        'speciality_id': specialityId,
        'user_id': userId,
        'teacher_whatsapp': teacherWhatsapp,
      };
}
