import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.tx,
    @required this.onDelete,
  }) : super(key: key);

  final Transaction tx;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(child: Text('\$${tx.amount}')),
          ),
        ),
        title: Text(tx.title,
            style: Theme.of(context).textTheme.headline6),
        subtitle: Text(DateFormat.yMMMd().format(tx.date)),
        trailing: MediaQuery.of(context).size.width > 460 ? TextButton.icon( icon: const Icon(Icons.delete),
            style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
            onPressed: () => onDelete(tx.id), label: const Text('Delete')) 
        : IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () => onDelete(tx.id)),
      ),
    );
  }
}