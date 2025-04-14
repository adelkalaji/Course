import 'package:flutter/material.dart';
import 'package:flutter_application_3/controller/course.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentSlide;
  const ImageSlider({
    super.key,
    required this.currentSlide,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: PageView(
              scrollDirection: Axis.horizontal,
              allowImplicitScrolling: true,
              onPageChanged: onChange,
              physics: const ClampingScrollPhysics(),
              children: [
                Image.network(
                  CourseApiController.Courses.elementAt(0).courseImage!,
                  fit: BoxFit.cover,
                ),
                Image.network(
                  CourseApiController.Courses.elementAt(1).courseImage!,
                  fit: BoxFit.cover,
                ),
                Image.network(
                  CourseApiController.Courses.elementAt(2).courseImage!,
                  fit: BoxFit.cover,
                ),
                Image.network(
                  CourseApiController.Courses.elementAt(3).courseImage!,
                  fit: BoxFit.cover,
                ),
                Image.network(
                  CourseApiController.Courses.elementAt(4).courseImage!,
                  fit: BoxFit.cover,
                ),
                Image.network(
                  CourseApiController.Courses.elementAt(5).courseImage!,
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                CourseApiController.Courses.length,
                (index) => AnimatedContainer(
                  duration: const Duration(microseconds: 300),
                  width: currentSlide == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentSlide == index
                          ? Colors.black
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
