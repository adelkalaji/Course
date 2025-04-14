// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/comitte/AnswerBottomSheet.dart';
import 'package:flutter_application_3/controller/QuestionListController.dart';
import 'package:flutter_application_3/models/question.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class MyQuestions extends StatefulWidget {
  @override
  _MyQuestionsState createState() => _MyQuestionsState();
}

class _MyQuestionsState extends State<MyQuestions> {
  final QuestionController questionController = Get.put(QuestionController());

  @override
  void initState() {
    super.initState();
    // Check the question IDs when initializing
    // ignore: avoid_function_literals_in_foreach_calls
    questionController.myquestions.forEach((question) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أسئلتي'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {
                  // Add your refresh logic here, such as fetching new data from an API
                  // You can call a method to refresh the data in the questionController
                  questionController.fetchQuestions();
                },
                child: ListView.builder(
                  itemCount: questionController.myquestions.length,
                  itemBuilder: (context, index) {
                    final question = questionController.myquestions[index];
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        // A pane can dismiss the Slidable.
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              _buildDeleteIcon(question);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
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
                                const SizedBox(height: 4),
                                Text(
                                  "السؤال ${index + 1}:",
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
                        title: Text(question.question ?? 'لايوجد أسئلة'),
                        onTap: () => _navigateToAnswerPage(context, question),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buildDeleteIcon(Question question) {
    if (question.qusId != null) {
      questionController.delete(question.qusId!);
    } else {}
  }

  void _navigateToAnswerPage(BuildContext context, Question question) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => AnswerPage(question: question),
      ),
    );
  }
}
