// ignore_for_file: non_constant_identifier_names

import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/models/course.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CourseApiController {
  // ignore: duplicate_ignore
  // ignore: non_constant_identifier_names
  static List<Course> Courses = [];
  static List<Course> SignedCourses = [];
  static List<Course> FavoriteCourses = [];

  void fetchDataFromApi() async {
    var url = Uri.http(Config.localhost, '/allcourse');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistCourse = json.decode(response.body) as List<dynamic>;
      Courses = decodedlistCourse.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  void signedcourse(String x) async {
    var url = Uri.http(Config.localhost, '/signedcourse/$x');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistCourse = json.decode(response.body) as List<dynamic>;
      SignedCourses =
          decodedlistCourse.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  void favoritecourse(String x) async {
    var url = Uri.http(Config.localhost, '/favoritecourse/$x');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistCourse = json.decode(response.body) as List<dynamic>;
      FavoriteCourses =
          decodedlistCourse.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
