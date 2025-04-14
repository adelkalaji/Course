import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/models/student.dart';
import 'package:flutter_application_3/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApiController extends GetxController {
  var listUser = [].obs;
  // ignore: non_constant_identifier_names
  static List<User> Users = [];

  @override
  void onInit() {
    super.onInit();
    fetchDataFromApi();
  }

  void fetchDataFromApi() async {
    var url = Uri.http(Config.localhost, '/user');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistUser = json.decode(response.body) as List<dynamic>;
      Users = decodedlistUser.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<bool> loginAPI(String userName, String userPass) async {
    var url = Uri.http(Config.localhost, '/userlogin');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(
            <String, String>{"User_name": userName, "User_pass": userPass}));
    if (response.statusCode == 200) {
      final decodedUser = json.decode(response.body);
      final message = decodedUser['message'];
      final userId = decodedUser['userId'];
      final userRole = decodedUser['userRole'];
      if (message != null && userId != null && userRole != null) {
        Config.userid = userId.toString();
        myInfo();

        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static List<Student> myinfolist = [];
  myInfo() async {
    var url = Uri.http(Config.localhost, '/students/${Config.userid}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistStudent = json.decode(response.body) as List<dynamic>;
      myinfolist =
          decodedlistStudent.map((json) => Student.fromJson(json)).toList();
      Config.studentid = myinfolist.elementAt(0).studentId.toString();
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<bool> registerAPI(
    String userName,
    String userPass,
    String userEmail,
  ) async {
    var url = Uri.http(Config.localhost, '/usersignup');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "User_name": userName,
          "User_pass": userPass,
          "User_Role": "0",
          "User_email": userEmail,
          "Speciality": "",
          "User_desc": "",
          "User_link": ""
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
