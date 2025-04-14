import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/log/splash_screen.dart';
import 'package:flutter_application_3/provider/favorite_provider.dart';
import 'package:flutter_application_3/controller/student.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  Get.put(StudentApiController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.mulishTextTheme(),
          ),
          home: const MySplashScreen(),
        ),
      );
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/log/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySplashScreen(),
    );
  }
}
*/