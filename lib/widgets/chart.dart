import 'package:flutter/material.dart';
import 'package:pea/model/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  // getters can be used to get maps from a list!
  List<Map<String, Object>> get getGroupedTransactionValues {
    // generate constructor will generate a list via some sort of callback function
    return List.generate(7, (index) {
      // bracket == Map
      // builtin methods in dart subtract and Duration() class
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        // looking into each datetime and selecting the day of it to compare with the weekDay
        // looks ugly af tbh, must be a better way for this
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      // DateFormat.E will return the weekDay
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    print(getGroupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
