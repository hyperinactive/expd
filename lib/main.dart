import 'package:flutter/material.dart';

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
  const MyHomePage({Key key}) : super(key: key);

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
          Card(
            child: Text('List placeholder'),
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
