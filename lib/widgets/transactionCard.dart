import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final transaction;
  final Function deleteTransaction;

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  Color _chosenColor;

  @override
  void initState() {
    const colors = [
      Colors.pink,
      Colors.purple,
      Colors.blue,
      Colors.amber,
    ];

    _chosenColor = colors[Random().nextInt(4)];
    super.initState();
  }

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
          backgroundColor: _chosenColor,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        // trailing is located at the end of the tile
        // if the width if greated than 460 (should be the case for bigger devices or devices in landscape mode)
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () =>
                    {widget.deleteTransaction(widget.transaction.id)},
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    // getting the index from the list builder
                    widget.deleteTransaction(widget.transaction.id),
              ),
      ),
    );
  }
}
