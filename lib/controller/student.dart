import 'dart:convert';
import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/models/student.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//import 'dart:convert';

class StudentApiController extends GetxController {
  var listStudent = [].obs;
  // ignore: non_constant_identifier_names
  static List<Student> Students = [];

  @override
  void onInit() {
    super.onInit();
    fetchDataFromApi();
  }

  fetchDataFromApi() async {
    var url = Uri.http(Config.localhost, '/students');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistStudent = json.decode(response.body) as List<dynamic>;
      Students =
          decodedlistStudent.map((json) => Student.fromJson(json)).toList();
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
