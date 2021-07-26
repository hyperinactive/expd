import 'package:flutter/material.dart';
import 'package:pea/widgets/transactionCard.dart';
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
                  const SizedBox(
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
          : ListView(
              children: [
                // render card widgets using the transaction list
                // keys ensure state refs won't pointing to wrong elements
                ...transactions
                    .map((e) => TransactionCard(
                        key: ValueKey(e.id),
                        transaction: e,
                        deleteTransaction: deleteTransaction))
                    .toList()
              ],
            ),
    );
  }
}
