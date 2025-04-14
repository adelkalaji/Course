// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/nav_bar_screen.dart';
import 'package:flutter_application_3/Utiles/colors.dart';
import 'package:flutter_application_3/controller/user.dart';
import 'package:flutter_application_3/home/widget/text_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController UserName = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController RePassword = TextEditingController();
  void goToPageLogin(BuildContext context) {
    UserApiController x = UserApiController();
    x.registerAPI(UserName.text, Password.text, Email.text);
    if (Password.text == RePassword.text) {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } else {
      // Show an error message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء التأكد من تطابق كلمة المرور')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            backgroundColor2,
            backgroundColor2,
            backgroundColor4,
          ],
        ),
      ),
      child: SafeArea(
          child: ListView(
        children: [
          SizedBox(height: size.height * 0.03),
          const Text(
            "أهلا بك في منصتنا",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 37,
              color: kprimaryColor,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "قم بالتسجيل الان",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 27, color: textColor2, height: 1.2),
          ),
          SizedBox(height: size.height * 0.04),
          // for username and password
          myTextField("اسم المستخدم", Colors.white, UserName),
          myTextField("كلمة المرور", Colors.black26, Password),
          myTextField("تأكيد كلمة المرور", Colors.black26, RePassword),
          myTextField("الحساب الالكتروني", Colors.white, Email),
          const SizedBox(height: 20),
          SizedBox(height: size.height * 0.04),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(children: [
              // for sign up button
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 60),
                onPressed: () => goToPageLogin(context),
                color: kprimaryColor,
                textColor: Colors.white,
                child: const Text(
                  "سجل الأن",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ]),
          ),
        ],
      )),
    ));
  }
}
