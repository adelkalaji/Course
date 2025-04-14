// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/models/question.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuestionController extends GetxController {
  var questions = <Question>[].obs;
  var myquestions = <Question>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
    fetchMyQuestions();
  }

  void fetchQuestions() async {
    try {
      var url = Uri.http(Config.localhost, '/question');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        questions.assignAll(data
            .map((questionJson) => Question.fromJson(questionJson))
            .toList());
      } else {
        errorMessage.value =
            'Failed to fetch questions: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
    }
  }

  void fetchMyQuestions() async {
    try {
      var url = Uri.http(Config.localhost, '/question/${Config.userid}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        myquestions.assignAll(data
            .map((questionJson) => Question.fromJson(questionJson))
            .toList());
      } else {
        errorMessage.value =
            'Failed to fetch my questions: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
    }
  }

  Future<bool> delete(int x) async {
    try {
      var url = Uri.http(Config.localhost, '/qus/$x');
      var response = await http.delete(url);

      if (response.statusCode == 200) {
        // Remove the deleted question from the observable list
        questions.removeWhere((question) => question.qusId == x);
        myquestions.removeWhere((question) => question.qusId == x);
        return true;
      } else {
        errorMessage.value =
            'Failed to delete question: ${response.statusCode}';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
      return false;
    }
  }

  Future<bool> addquestion1(String qus, String userid) async {
    try {
      var url = Uri.http(Config.localhost, '/qus');
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "question": qus,
            "user_id": userid,
          }));

      if (response.statusCode == 200) {
        // Optionally, you could fetch the questions again to update the list.
        // Or you could add the new question directly to the list.
        fetchQuestions();
        return true;
      } else {
        errorMessage.value = 'Failed to add question: ${response.statusCode}';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
      return false;
    }
  }

  Future<bool> updateQuestion(int qusId, String updatedQuestion) async {
    try {
      var url = Uri.http(Config.localhost, '/qus/$qusId');
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "question": updatedQuestion,
          }));

      if (response.statusCode == 200) {
        // Update the question in the observable list
        int index = questions.indexWhere((question) => question.qusId == qusId);
        if (index != -1) {
          questions[index] =
              questions[index].copyWith(question: updatedQuestion);
        }

        index = myquestions.indexWhere((question) => question.qusId == qusId);
        if (index != -1) {
          myquestions[index] =
              myquestions[index].copyWith(question: updatedQuestion);
        }
        return true;
      } else {
        errorMessage.value =
            'Failed to update question: ${response.statusCode}';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
      return false;
    }
  }
}
