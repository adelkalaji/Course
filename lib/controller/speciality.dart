import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/models/speciality.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpecialityApiController extends GetxController {
  var listSpeciality = [].obs;
  // ignore: non_constant_identifier_names
  static List<Speciality> Specialitys = [];
  @override
  void onInit() {
    super.onInit();
    fetchDataFromApi();
  }

  void fetchDataFromApi() async {
    var url = Uri.http(Config.localhost, '/speciality');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistSpeciality = json.decode(response.body) as List<dynamic>;
      Specialitys = decodedlistSpeciality
          .map((json) => Speciality.fromJson(json))
          .toList();
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
