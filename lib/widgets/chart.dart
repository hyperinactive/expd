import 'package:flutter/material.dart';
import 'package:pea/model/transaction.dart';
import 'package:intl/intl.dart';
import 'package:pea/widgets/charBar.dart';

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

  double get getTotalSpending {
    // fold can transoftm list into another type with certain logic passed to fold
    // sum starts out at 0 and will be incremented for every item in the list
    return getGroupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      // instead of creating a Container with padding just to padd something
      // can use Padding, a container that does that, basically it doesn't matter but it looks nice
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getGroupedTransactionValues.map((e) {
            // return Text('${e['day']} : ${e['amount']}'.substring(0, 1));
            // A widget that controls how a child of a Row, Column, or Flex flexes
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: e['day'],
                spendingAmount: e['amount'],
                spendingPercentage: getTotalSpending == 0
                    ? 0.0
                    : (e['amount'] as double) / getTotalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
