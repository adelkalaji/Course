// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_3/controller/answer.dart';
import 'package:flutter_application_3/models/question.dart';
import 'package:get/get.dart';

class AddAnswerForm extends StatelessWidget {
  final Question question;
  final AnswerController answerController = Get.find();
  final TextEditingController textController = TextEditingController();

  AddAnswerForm({required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: 'أضف إجابة جديدة'),
            ),
          ),
          const SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: () {
              answerController.addAnswer(
                textController.text,
                //  "1",
                question.qusId.toString(),
              );
              answerController.fetchAnswers(question.qusId.toString());
              textController.clear();
            },
            child: const Text('إضافة إجابة'),
          ),
        ],
      ),
    );
  }
}
