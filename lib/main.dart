import 'package:flutter/material.dart';
import 'package:pea/widgets/chart.dart';
import 'package:pea/widgets/transactionList.dart';
import 'package:uuid/uuid.dart';
import './widgets/newTransaction.dart';
import './model/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      // Theme Data - global collection of presets
      // to use the theme, use Theme()
      theme: ThemeData(
        // primarySwatch -> based on a singular color but sets up different shades of it
        // fontFamily from the pubspec file
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        appBarTheme: AppBarTheme(
            // copying the light theme of ThemeData's default but replace the title with our font
            textTheme: ThemeData.light().textTheme.copyWith(
                  // headline6 == title
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // flutter has a built-in function to show modals -> showModalBottomSheet
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var uuid = Uuid();
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: '1',
    //   title: 'Idk',
    //   amount: 29.00,
    //   date: DateTime.now(), // js thing with timestamps
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Idc',
    //   amount: 38.10,
    //   date: DateTime.now(), // js thing with timestamps
    // ),
  ];

  List<Transaction> get _recentTransactions {
    // where is the js's equivalent to filter
    // filter the list of transactions and only use those that happened after the current timestamp -7 days
    // isAfter method builtin method
    // iterable error - where will transform the list into an iterable, so a conversion into a list is needed
    return _userTransactions.where((e) {
      return e.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

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

  void _showNewTransactionModal(BuildContext context) {
    // requires a context which we provide in our function
    // note that this context is different from the one the builder needs
    // builder gives its own context

    // builder: (buildContext) {} - won't be using the context anyways, so using the _
    showModalBottomSheet(
      context: context,
      builder: (_) {
        // using GestureDetector to modify some gesture action
        // preventing the modal from closing upon a single tap on it
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(
            addTransationFn: _addTransaction,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses App'),
        // actions usually house icons
        // setting up floating action button and icon to open newTransaction modal
        // flutter provides its own materials for icons Icons.props
        actions: [
          IconButton(
            onPressed: () => _showNewTransactionModal(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      // Scaffold supports floating action buttons
      // setting up the floating button
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // providing the build context to our modal function
        onPressed: () => _showNewTransactionModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // scroll view gives us scroll functionality
      // to avoid overflows when keyboard pushes the page up when it opens
      // if added on a child widget, it is important to give it height or the scroll won't work properly
      body: SingleChildScrollView(
        child: Column(
          // ROW/COLUMN Main/Cross Axis
          crossAxisAlignment: CrossAxisAlignment.center,
          // <Widget> good practive to label the lists
          children: <Widget>[
            Card(
              // Cards are only as big as they need to fit the child
              child: Container(
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
                width: double.infinity,
                color: Colors.blue,
              ),
              elevation: 5, // drop shadow size
            ),
            TransactionList(
              transactions: _userTransactions,
            ),
          ],
        ),
      ),
    );
  }
}
