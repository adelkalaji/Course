import 'package:flutter/material.dart';
import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/controller/course.dart';
import 'package:flutter_application_3/controller/student_course_rel.dart';
import 'package:flutter_application_3/models/course.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Course> _favorites = [];
  List<Course> get favorites => _favorites;
  void addRel(String studentId, String courseId) {
    StudentCourseRelApiController x = StudentCourseRelApiController();
    x.favRel(Config.studentid, courseId);
    // ignore: unnecessary_new
    CourseApiController y = new CourseApiController();
    y.favoritecourse(Config.studentid);
  }

  void toggleFavorite(Course product) {
    _favorites.add(product);
    notifyListeners();
  }

  bool isExist(Course product) {
    final isExist = _favorites.contains(product);
    return isExist;
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
