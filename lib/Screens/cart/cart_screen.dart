import 'package:flutter/material.dart';
import 'package:flutter_application_3/Utiles/colors.dart';
import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/controller/course.dart';
import 'package:flutter_application_3/home/widget/signed_product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int currentSlider = 0;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    CourseApiController x = CourseApiController();
    x.signedcourse(Config.studentid);
    x.fetchDataFromApi();
    return Scaffold(
        backgroundColor: kcontentColor,
        appBar: AppBar(
          backgroundColor: kcontentColor,
          title: const Text(
            "الكورسات المسجل عليها",
            style: TextStyle(
              fontSize: 22, // Larger font size for impact
              fontWeight: FontWeight.bold,
              color: kprimaryColor, // Deeper blue color
              letterSpacing: 1.2, // Slightly increased letter spacing
              shadows: [
                Shadow(
                  color: Colors.grey, // Light gray shadow
                  offset: Offset(2, 2), // Shadow offset
                  blurRadius: 4, // Shadow blur radius
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          //physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),

          itemCount: CourseApiController.SignedCourses.length,
          itemBuilder: (context, index) {
            return SignedProduct(
                product: CourseApiController.SignedCourses.elementAt(index),
                index: index);
          },
        ));
  }
}
