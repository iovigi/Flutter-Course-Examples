import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function showDatePicker;

  AdaptiveButton({this.text, this.showDatePicker});

  @override
  Widget build(BuildContext context) {
    return  Platform.isIOS
                        ? CupertinoButton(
                            onPressed: showDatePicker,
                            color: Theme.of(context).primaryColor,
                            child: Text(text,
                                style: TextStyle(fontWeight: FontWeight.bold)))
                        : TextButton(
                            onPressed: showDatePicker,
                            style: TextButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                textStyle: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                            child: Text(text,
                                style: TextStyle(fontWeight: FontWeight.bold)));
  }
}