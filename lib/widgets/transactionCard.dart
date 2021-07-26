import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text('\$${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        // trailing is located at the end of the tile
        // if the width if greated than 460 (should be the case for bigger devices or devices in landscape mode)
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () => {deleteTransaction(transaction.id)},
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    // getting the index from the list builder
                    deleteTransaction(transaction.id),
              ),
      ),
    );
  }
}
