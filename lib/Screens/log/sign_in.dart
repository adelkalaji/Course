// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/log/register.dart';
import 'package:flutter_application_3/Screens/nav_bar_screen.dart';
import 'package:flutter_application_3/Utiles/colors.dart';
import 'package:flutter_application_3/home/widget/text_field.dart';
import 'package:flutter_application_3/controller/user.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController UserName = TextEditingController();
  TextEditingController Password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserApiController _userApiController = Get.put(UserApiController());

  @override
  void initState() {
    super.initState();
    UserName = TextEditingController();
    Password = TextEditingController();
  }

  @override
  void dispose() {
    UserName.dispose();
    Password.dispose();
    super.dispose();
  }

  void _attemptLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool loginSuccess =
          await _userApiController.loginAPI(UserName.text, Password.text);

      if (loginSuccess) {
        // Navigate to the next screen after successful login
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
        );
      } else {
        // Show an error message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('الرجاء التأكد من اسم المستخدم و كلمة السر')),
        );
      }
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
              "منصة زدني",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 37,
                color: kprimaryColor,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "اهلا بك مجددا في منصتنا",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27, color: textColor2, height: 1.2),
            ),
            Text(
              "! لقد اشتقنا لك",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27, color: textColor2, height: 1.2),
            ),
            SizedBox(height: size.height * 0.04),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  myTextField(" اسم المستخدم", Colors.white, UserName),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: Password,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 22,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "كلمة المرور",
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerRight,
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 60),
                    onPressed: () => _attemptLogin(context),
                    color: kprimaryColor,
                    textColor: Colors.white,
                    child: const Text(
                      "تسجيل الدخول",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: size.height * 0.07),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Register(),
                      ),
                    ),
                    child: Text.rich(
                      TextSpan(
                          text: " لست عضوا ؟",
                          style: TextStyle(
                            color: textColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          children: const [
                            TextSpan(
                              text: " سجل الان ماذا تنتظر؟",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> goToPageLogin(BuildContext context) async {
    UserApiController x = UserApiController();
    Future<bool> islogin = x.loginAPI(UserName.text, Password.text);
    if (await islogin) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavBar(),
        ),
      );
    } else {}
  }

  Container socialIcon(image) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Image.asset(
        image,
        height: 35,
      ),
    );
  }
}
