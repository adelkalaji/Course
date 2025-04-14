import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/log/splash_screen.dart';
import 'package:flutter_application_3/Screens/profile/profile_screens/about_us.dart';
import 'package:flutter_application_3/Screens/profile/profile_screens/info.dart';
import 'package:flutter_application_3/Screens/profile/components/profile_menu.dart';
import 'package:flutter_application_3/Screens/profile/profile_screens/my_questions.dart';
import 'package:flutter_application_3/Utiles/colors.dart';
import 'package:flutter_application_3/controller/user.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            UserApiController.myinfolist.elementAt(0).studentImage!,
            fit: BoxFit.cover,
            height: size.height,
            width: size.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 30),
            child: Column(
              children: [
                // const ProfilePic(),
                const SizedBox(height: 20),
                Text(
                  "${UserApiController.myinfolist.elementAt(0).studentName}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                      color: kprimaryColor),
                ),
                ProfileMenu(
                  text: "الحساب الشخصي",
                  icon: "images/User Icon.svg",
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Info(),
                    ),
                  ),
                ),
                ProfileMenu(
                  text: "الأسئلة التي قمت بطرحها",
                  icon: "images/Bell.svg",
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyQuestions(),
                      )),
                ),

                ProfileMenu(
                  text: "لمحة عنا",
                  icon: "images/Question mark.svg",
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const AboutUs(),
                      )),
                ),
                ProfileMenu(
                    text: "تسجيل الخروج",
                    icon: "images/Log out.svg",
                    press: () => Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const MySplashScreen(),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
