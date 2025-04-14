import 'package:flutter_application_3/config/config.dart';

class Student {
  int? studentId;
  String? studentName;
  String? studentEmail;
  String? studentJoin;
  String? studentImage;
  int? userId;

  Student({
    this.studentId,
    this.studentName,
    this.studentEmail,
    this.studentJoin,
    this.studentImage,
    this.userId,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['student_id'],
      studentName: json['student_name'],
      studentEmail: json['student_email'],
      studentJoin: json['student_join'],
      studentImage: Config.image + json['student_image'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'student_id': studentId,
        'student_name': studentName,
        'student_email': studentEmail,
        'student_join': studentJoin,
        'student_image': studentImage,
        'user_id': userId,
      };
}
