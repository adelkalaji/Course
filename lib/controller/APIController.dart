// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, non_constant_identifier_names

import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/models/answer.dart';
import 'package:flutter_application_3/models/question.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIController {
  static List<Question> Questions = [];
  static List<Answer> Answers = [];

  Future<int> getQuestions() async {
    var url = Uri.http(Config.localhost, '/qus');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistQuestion = json.decode(response.body) as List<dynamic>;
      Questions =
          decodedlistQuestion.map((json) => Question.fromJson(json)).toList();
      return 1;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<List<Answer>> getAnswers(String id) async {
    var url = Uri.http(Config.localhost, '/allanswer/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedlistAnser = json.decode(response.body) as List<dynamic>;
      List<Answer> answers =
          decodedlistAnser.map((json) => Answer.fromJson(json)).toList();
      return answers;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  void addQuestion(String question) async {}
}
