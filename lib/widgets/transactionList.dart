import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      // hard-coded, % based height/width would be optimal
      // height: 450, has to be connected to the context
      // Column + SingleChildScrollView == ListView widget
      // still needs height though

      // ListView if provided with children, will render them all!!!
      // use the builder() constructor instead, as it will only render visible widgets

      // builder will call for rendering each time it's needed to render a widget
      // it needs an itemBuilder, a function given by flutter, gives a context and index
      // index tells the currently rendered item
      child: transactions.isEmpty
          // constraints are super useful
          // finding out the height of the parent widget is super useful
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    'No Transactions added yet',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  // commonly used as separators, occupies spaces, doesn't need a child
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                // return Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         child: Text(
                //           // js string literals
                //           // fixed string limits the number of characters
                //           '\$${transactions[index].amount.toStringAsFixed(2)}',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             color: Colors.pink,
                //           ),
                //         ),
                //         // margin and padding, both use EdgeInsets class
                //         padding: EdgeInsets.all(10),
                //         margin:
                //             EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //           // taking the primary color of the swatch
                //           color: Theme.of(context).primaryColor,
                //           width: 2,
                //         )),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transactions[index].title,
                //             // using the ThemeData's text theme
                //             style: Theme.of(context).textTheme.headline6,
                //           ),
                //           Text(
                //             // from intl package
                //             DateFormat.yMEd()
                //                 .add_jm()
                //                 .format(transactions[index].date),
                //             style: TextStyle(
                //               color: Theme.of(context).primaryColor,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
                // builtin class in flutter, looks nice
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    // trailing is located at the end of the tile
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          // getting the index from the list builder
                          deleteTransaction(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
              // render card widgets using the transaction list
            ),
    );
  }
}
