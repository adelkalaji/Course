import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/models/teacher.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeacherApiController extends GetxController {
  var listTeacher = [].obs;
  // ignore: non_constant_identifier_names
  static List<Teacher> Teachers = [];

  @override
  void onInit() {
    super.onInit();
    fetchDataFromApi();
  }

  void fetchDataFromApi() async {
    var url = Uri.http(Config.localhost, '/teacher');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistTeacher = json.decode(response.body) as List<dynamic>;
      Teachers =
          decodedlistTeacher.map((json) => Teacher.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }
/*
  static void AddCategoryToApi(String name) async {
    final queryParameters = {
      "name": name,
    };
    var url = Uri.http(
        "Config.ip", '/apilibrary/category/insertCategory.php', queryParameters);
    final response = await http.get(url);
    // print(response.body);
    if (response.statusCode == 200) {
      print("Success Add");
    } else {
      throw Exception('FailedAdd data To Category');
    }
  }
  */
}
