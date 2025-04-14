import 'dart:convert';
import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/models/answer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AnswerController extends GetxController {
  var answers = <Answer>[].obs;

  void fetchAnswers(String questionId) async {
    var url = Uri.http(Config.localhost, '/allanswer/$questionId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      answers.assignAll(
          data.map((answerJson) => Answer.fromJson(answerJson)).toList());
    }
  }

  void addAnswer(String answerText, String questionId) async {
    try {
      var url = Uri.http(Config.localhost, '/answer');
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "answer": answerText,
            "User_id": Config.userid,
            "qus_id": questionId,
          }));

      if (response.statusCode == 200) {
        // Optionally, you could fetch the questions again to update the list.
        // Or you could add the new question directly to the list.
        fetchAnswers(questionId);
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }
}
