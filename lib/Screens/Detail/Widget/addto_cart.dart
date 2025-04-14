import 'package:flutter_application_3/Utiles/colors.dart';
import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/controller/course.dart';
import 'package:flutter_application_3/controller/student_course_rel.dart';
import 'package:flutter_application_3/models/course.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  final Course product;
  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            addRel(context, widget.product.courseId.toString());
            const snackBar = SnackBar(
              content: Text(
                "Successfully added!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: kprimaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: const Text(
              "Add to Cart",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  void addRel(BuildContext context, String courseId) {
    StudentCourseRelApiController x = StudentCourseRelApiController();
    x.rel(Config.studentid, courseId);
    // ignore: unnecessary_new
    CourseApiController y = new CourseApiController();
    y.signedcourse(Config.studentid);
  }
}
