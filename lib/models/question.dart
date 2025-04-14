import 'package:flutter_application_3/config/config.dart';

class Question {
  int? qusId;
  String? question;
  DateTime? qusDate;
  int? userId;
  int? studentId;
  String? studentName;
  String? studentEmail;
  DateTime? studentJoin;
  String? studentImage;
  String? userName;
  String? userPass;
  int? userRole;

  Question({
    this.qusId,
    this.question,
    this.qusDate,
    this.userId,
    this.studentId,
    this.studentName,
    this.studentEmail,
    this.studentJoin,
    this.studentImage,
    this.userName,
    this.userPass,
    this.userRole,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      qusId: json['qus_id'],
      question: json['question'],
      qusDate: DateTime.parse(json['qus_date']),
      userId: json['user_id'],
      studentId: json['student_id'],
      studentName: json['student_name'],
      studentEmail: json['student_email'],
      studentJoin: DateTime.parse(json['student_join']),
      studentImage: Config.image + json['student_image'],
      userName: json['user_name'],
      userPass: json['user_pass'],
      userRole: json['user_role'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'qus_id': qusId,
      'question': question,
      'qus_date': qusDate,
      'user_id': userId,
      'student_id': studentId,
      'student_name': studentName,
      'student_email': studentEmail,
      'student_join': studentJoin,
      'student_image': studentImage,
      'user_name': userName,
      'user_pass': userPass,
      'user_role': userRole,
    };
  }

  Question copyWith({
    int? qusId,
    String? question,
    String? qusDate,
    int? userId,
  }) {
    return Question(
      qusId: qusId ?? this.qusId,
      question: question ?? this.question,
      userId: userId ?? this.userId,
    );
  }
}
