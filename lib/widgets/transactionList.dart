import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // Column + SingleChildScrollView == ListView widget
      // still needs height though

      // ListView if provided with children, will render them all!!!
      // use the builder() constructor instead, as it will only render visible widgets

      // builder will call for rendering each time it's needed to render a widget
      // it needs an itemBuilder, a function given by flutter, gives a context and index
      // index tells the currently rendered item
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: [
                Container(
                  child: Text(
                    // js string literals
                    '\$${transactions[index].amount}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.pink,
                    ),
                  ),
                  // margin and padding, both use EdgeInsets class
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink, width: 2)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      // from intl package
                      DateFormat.yMEd()
                          .add_jm()
                          .format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
        // render card widgets using the transaction list
      ),
    );
  }
}
