import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function onDelete;

  TransactionList({this.userTransactions, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
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
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                              child:
                                  Text('\$${tx.amount}')),
                        ),
                      ),
                      title: Text(tx.title,
                          style: Theme.of(context).textTheme.headline6),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(tx.date)),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => onDelete(tx.id)),
                    ),
                  );
                },
                itemCount: userTransactions.length,
              ));
  }
}
