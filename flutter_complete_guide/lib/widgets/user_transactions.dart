import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';

import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(id: '1', title: 'Food', amount: 49, date: DateTime.now()),
    Transaction(id: '2', title: 'Fuel', amount: 39, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [NewTransaction(addTransaction: _addTransaction,), TransactionList(userTransactions: _userTransactions,)],
    );
  }

  void _addTransaction(String title, double amount){
    final newTx = new Transaction(id: '${_userTransactions.length + 1}', title: title, amount: amount, date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }
}
