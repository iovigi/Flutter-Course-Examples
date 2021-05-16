import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _i = 0;

  var _questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': ['Red', 'Blue', 'Puple']
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': ['Cat', 'Dog', 'Cow']
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: [
            Question(questionText: _questions[_i]['questionText']),
            ...(_questions[_i]['answers'] as List<String>)
                .map((question) => Answer(
                      onPressed: _press,
                      answerText: question,
                    ))
          ],
        ),
      ),
    );
  }

  void _press() {
    setState(() {
      _i++;
      if (_questions.length == _i) {
        _i = 0;
      }
    });
  }
}
