import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/user_transactions.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      title: 'Flutter App',
    );
  }
}

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter App')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                child: Card(
                  color: Colors.blue,
                  child: Text(
                    'CHART!',
                    textAlign: TextAlign.center,
                  ),
                  elevation: 5,
                ),
                width: double.infinity),
            UserTransactions()
          ],
        ),
      ),
    );
  }
}
