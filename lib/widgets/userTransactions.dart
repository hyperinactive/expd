import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../model/transaction.dart';
import '../widgets/transactionList.dart';
import './newTransaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  var uuid = Uuid();
  final List<Transaction> _userTransactions = [
    Transaction(
      id: '1',
      title: 'Idk',
      amount: 29.00,
      date: DateTime.now(), // js thing with timestamps
    ),
    Transaction(
      id: '2',
      title: 'Idc',
      amount: 38.10,
      date: DateTime.now(), // js thing with timestamps
    ),
  ];

  void _addTransaction(String title, double amount) {
    final newTransaction = Transaction(
      id: uuid.v4(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          addTransationFn: _addTransaction,
        ),
        TransactionList(transactions: _userTransactions),
      ],
    );
  }
}
