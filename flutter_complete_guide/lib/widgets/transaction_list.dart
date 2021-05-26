import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function onDelete;

  TransactionList({this.userTransactions, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, contraint) {
            return Column(children: [
              Text('No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 25),
              Container(
                  height: contraint.maxHeight * 0.7,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover))
            ]);
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(tx: userTransactions[index], onDelete: onDelete);
            },
            itemCount: userTransactions.length,
          );
  }
}
