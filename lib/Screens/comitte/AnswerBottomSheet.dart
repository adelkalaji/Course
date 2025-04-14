// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/comitte/addAnswerForm.dart';
import 'package:flutter_application_3/controller/answer.dart';
import 'package:flutter_application_3/models/question.dart';
import 'package:get/get.dart';

class AnswerPage extends StatefulWidget {
  final Question question;

  const AnswerPage({required this.question});

  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final AnswerController answerController = Get.put(AnswerController());

  @override
  void initState() {
    super.initState();
    answerController.fetchAnswers(widget.question.qusId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإجابات على ${widget.question.question}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {
                  // Add your refresh logic here, such as fetching new data from an API
                  // You can call a method to refresh the data in the questionController
                  answerController
                      .fetchAnswers(widget.question.qusId.toString());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: answerController.answers.length,
                  itemBuilder: (context, index) {
                    final answer = answerController.answers[index];
                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(answer.studentImg!),
                          ),
                          const SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                answer.studentName!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Answer ${index + 1}:",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      title: Text(answer.answer!),
                    );
                  },
                ),
              ),
            ),
          ),
          AddAnswerForm(question: widget.question),
        ],
      ),
    );
  }
}
