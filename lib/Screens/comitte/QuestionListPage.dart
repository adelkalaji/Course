// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/comitte/AnswerBottomSheet.dart';
import 'package:flutter_application_3/Screens/comitte/addQuestionForm.dart';
import 'package:flutter_application_3/controller/QuestionListController.dart';
import 'package:get/get.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final QuestionController questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أسئلة'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(() => RefreshIndicator(
                  onRefresh: () async {
                    // Add your refresh logic here, such as fetching new data from an API
                    // You can call a method to refresh the data in the questionController
                    questionController.fetchQuestions();
                  },
                  child: ListView.builder(
                    itemCount: questionController.questions.length,
                    itemBuilder: (context, index) {
                      final question = questionController.questions[index];
                      return ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  NetworkImage(question.studentImage!),
                            ),
                            const SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  question.studentName!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  " ${index + 1}السؤال :",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        titleAlignment: ListTileTitleAlignment.bottom,
                        title: Text(question.question ?? "لا يوجد اسئلة"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AnswerPage(question: question),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )),
          ),
          AddQuestionForm(),
        ],
      ),
    );
  }
}
