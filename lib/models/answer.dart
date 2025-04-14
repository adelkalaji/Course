import 'package:flutter_application_3/config/config.dart';

class Answer {
  int? ansId;
  String? answer;
  String? ansDate;
  int? qusId;
  int? userId;
  String? studentImg;
  String? email;
  String? studentName;

  Answer(
      {this.ansId,
      this.answer,
      this.ansDate,
      this.qusId,
      this.userId,
      this.studentImg,
      this.email,
      this.studentName});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      ansId: json['ans_id'],
      answer: json['answer'],
      ansDate: json['ans_date'],
      qusId: json['qus_id'],
      userId: json['user_id'],
      studentImg: Config.image + json['img'],
      email: json['email'],
      studentName: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'ans_id': ansId,
        'answer': answer,
        'ans_date': ansDate,
        'qus_id': qusId,
        'user_id': userId,
        "img": studentImg,
        "email": email,
        "name": studentName
      };
}
