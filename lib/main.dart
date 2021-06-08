import 'package:flutter/material.dart';
import 'package:pea/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 1,
      title: 'Idk',
      amount: 29.00,
      date: DateTime.now(), // js thing with timestamps
    ),
    Transaction(
      id: 2,
      title: 'Idc',
      amount: 38.10,
      date: DateTime.now(), // js thing with timestamps
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Column(
        // ROW/COLUMN Main/Cross Axis
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // <Widget> good practive to label the lists
        children: <Widget>[
          Card(
            // Cards are only as big as they need to fit the child
            child: Container(
              child: Text('Chart placeholder'),
              width: double.infinity,
              color: Colors.blue,
            ),
            elevation: 5, // drop shadow size
          ),
          Column(
            // render card widgets using the transaction list
            children: transactions.map((e) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      child: Text(e.amount.toString()),
                      // margin and padding, both use EdgeInsets class
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2)),
                    ),
                    Column(
                      children: [
                        Text(e.title),
                        Text(e.date.toIso8601String().toString()),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
