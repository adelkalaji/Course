import 'package:flutter_application_3/config/config.dart';

class Video {
  String? videoId;
  String? videoName;
  String? videoPic;
  String? videoPath;
  String? courseId;
  String? courseName;

  Video(
      {this.videoId,
      this.videoName,
      this.videoPic,
      this.videoPath,
      this.courseId,
      this.courseName});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      videoId: json['id'],
      videoPic: Config.image + json['video_pic'],
      videoName: json['video_name'],
      videoPath: json['video_path'],
      courseName: json['course_name'],
      courseId: json['Course_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_id': videoId,
      'video_name': videoName,
      'video_pic': videoPic,
      'video_path': videoPath,
      'course_name': courseName,
      'Course_id': courseId,
    };
  }
}
