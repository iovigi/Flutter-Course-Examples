import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final Map<String, Object> question;
  final Function onPressed;

  Quiz({@required this.question, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questionText: question['questionText']),
        ...(question['answers'] as List<Map<String, Object>>)
            .map((question) => Answer(
                  onPressed:  () => onPressed(question['score']),
                  answerText: question['text'],
                ))
      ],
    );
  }
}
