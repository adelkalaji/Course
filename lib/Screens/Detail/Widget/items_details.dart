import 'package:flutter_application_3/Utiles/colors.dart';
import 'package:flutter_application_3/controller/student_course_rel.dart';
import 'package:flutter_application_3/controller/teacher.dart';
import 'package:flutter_application_3/models/course.dart';
import 'package:flutter/material.dart';

class ItemsDetails extends StatefulWidget {
  final Course product;
  const ItemsDetails({super.key, required this.product});

  @override
  State<ItemsDetails> createState() => _ItemsDetailsState();
}

class _ItemsDetailsState extends State<ItemsDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.courseName!,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  " عدد الساعات : ${widget.product.courseHours}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  " ${TeacherApiController.Teachers.elementAt(0).teacherName} : الأستاذ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                // for rating
                Container(
                  width: 55,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kprimaryColor,
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        StudentCourseRelApiController.StudentCourseRels
                                .elementAt(1)
                            .studentCourseEvaluation
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // const Spacer(),
          ],
        )
      ],
    );
  }
}
