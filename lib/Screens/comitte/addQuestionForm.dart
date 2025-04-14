// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_3/config/config.dart';
import 'package:flutter_application_3/controller/QuestionListController.dart';
import 'package:get/get.dart';

class AddQuestionForm extends StatelessWidget {
  final QuestionController questionController = Get.find();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: 'أضف سؤالًا جديدًا'),
            ),
          ),
          const SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: () {
              questionController.addquestion1(
                  textController.text, Config.userid);
              textController.clear();

              questionController.fetchQuestions();
              //questionController.obs.refresh();
            },
            child: const Text('إضافة سؤال'),
          ),
        ],
      ),
    );
  }
}
