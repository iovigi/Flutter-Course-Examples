import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Function onPressed;

  Answer({this.answerText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(getColor),
            textStyle:
                MaterialStateProperty.all(TextStyle(color: Colors.white)),
          ),
          onPressed: onPressed,
          child: Text(answerText),
        ));
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blueAccent;
  }
}
