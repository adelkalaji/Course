// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/log/register.dart';
import 'package:flutter_application_3/Screens/log/sign_in.dart';
import 'package:flutter_application_3/Utiles/colors.dart';
import 'package:flutter_application_3/controller/course.dart';
import 'package:flutter_application_3/controller/advertisment.dart';
import 'package:flutter_application_3/controller/speciality.dart';
import 'package:flutter_application_3/controller/student.dart';
import 'package:flutter_application_3/controller/student_course_rel.dart';
import 'package:flutter_application_3/controller/student_video_rel.dart';
import 'package:flutter_application_3/controller/teacher.dart';
import 'package:flutter_application_3/controller/user.dart';
import 'package:flutter_application_3/controller/video.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CourseApiController CourseController = CourseApiController();
    CourseController.fetchDataFromApi();
    AdvertismentApiController AdvertisementController =
        AdvertismentApiController();
    AdvertisementController.fetchDataFromApi();
    /*AnswerApiController AnswerController = Ans();
    AnswerController.fetchDataFromApi();
    QuestionApiController questionController = QuestionApiController();
    questionController.fetchDataFromApi();*/
    SpecialityApiController SpecialityController = SpecialityApiController();
    SpecialityController.fetchDataFromApi();
    StudentCourseRelApiController StudentCourseRelController =
        StudentCourseRelApiController();
    StudentCourseRelController.fetchDataFromApi();
    StudentVideoRelApiController StudentVideoRelController =
        StudentVideoRelApiController();
    StudentVideoRelController.fetchDataFromApi();
    StudentApiController StudentController = StudentApiController();
    StudentController.fetchDataFromApi();
    TeacherApiController TeacherController = TeacherApiController();
    TeacherController.fetchDataFromApi();
    UserApiController UserController = UserApiController();
    UserController.fetchDataFromApi();
    VideosApiController VideosController = VideosApiController();
    VideosController.fetchDataFromApi();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: backgroundColor1,
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.53,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: const Color.fromRGBO(250, 250, 250, 1),
                  boxShadow: [
                    BoxShadow(
                      // ignore:deprecated_member_use
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ],
                  image: const DecorationImage(
                    image: AssetImage(
                      "images/main.png",
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.6,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "منصة زدني التعليمية",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: kprimaryColor,
                          height: 1.2),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "أكتشف أفضل الكورسات العالمية \n التي تهتم بجميع المواهب والاختصاصات",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor2,
                      ),
                    ),
                    SizedBox(height: size.height * 0.07),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: backgroundColor3.withOpacity(0.9),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.05),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Row(
                            children: [
                              Container(
                                height: size.height * 0.08,
                                width: size.width / 2.2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Register(),
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      "سجل الان",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: textColor1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignIn(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: textColor1,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
