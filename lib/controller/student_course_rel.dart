// ignore_for_file: non_constant_identifier_names

import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/models/student_course_rel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentCourseRelApiController extends GetxController {
  var listStudentCourseRel = [].obs;
  // ignore: duplicate_ignore
  // ignore: non_constant_identifier_names
  static List<StudentCourseRel> StudentCourseRels = [];

  @override
  void onInit() {
    super.onInit();
    fetchDataFromApi();
  }

  void fetchDataFromApi() async {
    var url = Uri.http(Config.localhost, '/student_course_rel');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistStudentCourseRel =
          json.decode(response.body) as List<dynamic>;
      StudentCourseRels = decodedlistStudentCourseRel
          .map((json) => StudentCourseRel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<bool> rel(
    String student_id,
    String course_id,
  ) async {
    var url = Uri.http(Config.localhost, '/enrollcouse');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "student_id": student_id,
          "course_id": course_id,
        }));
    if (response.statusCode == 200) {
      fetchDataFromApi();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> favRel(
    String student_id,
    String course_id,
  ) async {
    var url = Uri.http(Config.localhost, '/setfavoritcourse');
    final response = await http.put(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "student_id": student_id,
          "course_id": course_id,
        }));
    if (response.statusCode == 200) {
      fetchDataFromApi();
      return true;
    } else {
      return false;
    }
  }
}
