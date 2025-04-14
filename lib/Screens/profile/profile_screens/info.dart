// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/profile/components/profile_pic.dart';
import 'package:flutter_application_3/Utiles/colors.dart';
import 'package:flutter_application_3/controller/user.dart';
import 'package:flutter_application_3/home/widget/text_field.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  TextEditingController UserName = TextEditingController(
      text: UserApiController.myinfolist.elementAt(0).studentName);
  TextEditingController Email = TextEditingController(
      text: UserApiController.myinfolist.elementAt(0).studentEmail);
  TextEditingController Password = TextEditingController();
  TextEditingController RePassword = TextEditingController();
  void goToPageLogin(BuildContext context) {
    UserApiController x = UserApiController();
    x.registerAPI(UserName.text, Password.text, Email.text);
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

          // for username and password
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: const ProfilePic()),
          myTextField("كلمة المرور", Colors.black26, UserName),
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
                  " حفظ التعديل ",
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
