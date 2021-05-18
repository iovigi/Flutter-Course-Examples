import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function onPressed;

  Result({this.score, this.onPressed});

  String get resultPhrase {
    var resultText = 'You did it! Your score is ' + score.toString();

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        TextButton(onPressed: onPressed, child: Text('Restart Quiz!'))
      ],
    ));
  }
}
