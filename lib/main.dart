import 'package:flutter/material.dart';
import 'package:pea/transaction.dart';
import 'package:intl/intl.dart';

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
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text('Add'),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.pink))),
              ]),
            ),
          ),
          Column(
            // render card widgets using the transaction list
            children: transactions.map((e) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        // js string literals
                        '\$${e.amount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.pink,
                        ),
                      ),
                      // margin and padding, both use EdgeInsets class
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink, width: 2)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          // from intl package
                          DateFormat.yMEd().add_jm().format(e.date),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
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
