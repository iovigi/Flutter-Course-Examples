import 'package:flutter/material.dart';

import 'quiz.dart';
import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _i = 0;
  int _totalScore = 0;

  var _questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Red', 'score': 5},
        {'text': 'Blue', 'score': 3},
        {'text': 'Pink', 'score': 2}
      ]
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Cat', 'score': 1},
        {'text': 'Dog', 'score': 2},
        {'text': 'Cow', 'score': 3}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_i == _questions.length ? 'Result:' + _totalScore.toString() : 'Quiz'),
          centerTitle: true,
        ),
        body: _i == _questions.length
            ? Result(
                onPressed: _resetQuiz,
                score: _totalScore,
              )
            : Quiz(question: _questions[_i], onPressed: _press),
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _i = 0;
      _totalScore = 0;
    });
  }

  void _press(int score) {
    if (_i == _questions.length) {
      return;
    }

    _totalScore += score;

    setState(() {
      _i++;
    });
  }
}
