import 'package:flutter/foundation.dart';

class Transaction {
  // final cus I don't expect them to change, no updating will be happening
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
