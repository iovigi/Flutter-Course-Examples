import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList({this.userTransactions});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: userTransactions.isEmpty
            ? Column(children: [
                Text('No transaction added yet!',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 25),
                Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ])
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  var tx = userTransactions[index];
                  return Card(
                      child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${tx.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.title,
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            DateFormat.yMMMd().format(tx.date),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.left,
                          )
                        ],
                      )
                    ],
                  ));
                },
                itemCount: userTransactions.length,
              ));
  }
}
