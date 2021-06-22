// will tell what platform the code is running on
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import 'style/androidThemeData.dart';
import './widgets/chart.dart';
import './widgets/transactionList.dart';
import './widgets/newTransaction.dart';
import './model/transaction.dart';

void main() {
  // uncomment if landscape mode isn't meant to be supported
  // // inits the bindings if necessary (for some devices)
  // WidgetsFlutterBinding.ensureInitialized();
  // // SystemChrome sets the system-wide settings for the app
  // // code down will lock the app into a portrait mode
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      // Theme Data - global collection of presets
      // to use the theme, use Theme()
      theme: AndroidThemeData().themeData,
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

  bool _showCharts = false;

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

  void _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: uuid.v4(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
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
            addTransactionCallback: _addTransaction,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // our context's media query object
    // better to create if once like this than to call media query on our cotext multiple times in the code
    final mediaQuery = MediaQuery.of(context);
    // bool run on every render which checks if the app is in landscape mode
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    // storing it like this so I can tell the height of the appBar
    // gets rid of the warning messages regarding the preferredSize
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              // take the minimum size the children need
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _showNewTransactionModal(context),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
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
          );

    final transactionList = Container(
      // MediaQuery == @media
      // size gets the device's height and width => 60%
      // subtract padding of the status bar
      // padding.top - get the top padding info
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appBar.preferredSize.height) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTransaction: _deleteTransaction,
      ),
    );

    // SafeArea makes sure to stay outside the reserved areas of the device
    final appBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // ROW/COLUMN Main/Cross Axis
        crossAxisAlignment: CrossAxisAlignment.center,
        // <Widget> good practive to label the lists
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show expenses chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                // on off slider widget
                // .adaptive changes the loop automatically based on platform
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showCharts,
                  onChanged: (e) {
                    setState(() {
                      _showCharts = e;
                    });
                  },
                ),
              ],
            ),
          // Cards are only as big as they need to fit the child
          // prefferedSize contains the size of a widget
          // subrtractingn the height of the chart container and appBar * 0.4

          // if not in the landscape mode show the smaller chart and transaction list
          // else show the switch that controls the large chart/transaction list
          if (!isLandscape)
            Container(
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height) *
                  0.3,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
              // width: double.infinity,
            ),
          if (!isLandscape) transactionList,
          if (isLandscape)
            _showCharts
                ? Container(
                    height: (mediaQuery.size.height -
                            mediaQuery.padding.top -
                            appBar.preferredSize.height) *
                        0.7,
                    child: Chart(
                      recentTransactions: _recentTransactions,
                    ),
                    // width: double.infinity,
                  )
                : transactionList
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: appBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            // Scaffold supports floating action buttons
            // setting up the floating button
            // check the platform and render the button if the device isn't IOS
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    // providing the build context to our modal function
                    onPressed: () => _showNewTransactionModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            // scroll view gives us scroll functionality
            // to avoid overflows when keyboard pushes the page up when it opens
            // if added on a child widget, it is important to give it height or the scroll won't work properly
            body: appBody,
          );
  }
}
