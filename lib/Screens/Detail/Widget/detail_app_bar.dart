import 'package:flutter/material.dart';
import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/controller/course.dart';
import 'package:flutter_application_3/controller/student_course_rel.dart';
import 'package:flutter_application_3/models/course.dart';
import 'package:flutter_application_3/provider/favorite_provider.dart';

class DetailAppBar extends StatelessWidget {
  final Course product;
  const DetailAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Spacer(),
          const SizedBox(width: 10),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              addRel(Config.studentid, product.courseId.toString());
            },
            icon: Icon(
              provider.isExist(product)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }

  void addRel(String studentId, String courseId) {
    StudentCourseRelApiController x = StudentCourseRelApiController();
    x.favRel(Config.studentid, courseId);
    // ignore: unnecessary_new
    CourseApiController y = new CourseApiController();
    y.favoritecourse(Config.studentid);
  }
}
