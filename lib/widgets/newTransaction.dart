import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pea/widgets/adaptiveButton.dart';

class NewTransaction extends StatefulWidget {
  // even though the widget is stateless, input doesn't need to render any widget so it's fine like this
  // normally you'd want stateful widget for it anyway
  // String titleInput;
  // String amountInput;

  // alternative - use controllers (listeners more like)
  final Function addTransactionCallback;

  NewTransaction({this.addTransactionCallback}) {
    print('constructor new transaction widget');
  }

  @override
  _NewTransactionState createState() {
    print('create state');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleInputController = TextEditingController();
  final TextEditingController _amountInputController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('constructor inside the state');
  }

  @override
  void initState() {
    print('initState');
    // super is the base State constuctor
    super.initState();
  }

  // lifecycle method
  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
  // State doesn't get autorebuilt because if just holds a ref of the element that manages the state
  // and is just updated to point to the new widget
  // Lifecycle goes like this:

  // widget constructor
  // createState (if widget updated it doesn't automatically get called (is rebuilt))
  // state constructor (if widget updated it doesn't automatically get called (is rebuilt))
  // initState (if widget updated it doesn't automatically get called (is rebuilt))
  // dispose

  // initState usually used to fetch data
  // didUpdate usually used when parent changes and data needs refetching
  // dispose cleans up connections to server or memory leaks

  void _submit() {
    if (_titleInputController.text.isEmpty ||
        _amountInputController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }

    final title = _titleInputController.text;
    final amount = double.parse(_amountInputController.text);

    // check if inputs are valid
    if (title.isEmpty || amount <= 0) {
      return;
    }

    // widget.props
    // normally, stuff from other classes cannot be directly used by another one
    // but widget and state class are connected and flutter has this widget keyword to help with it
    // work with the props in the widget class inside the state class
    widget.addTransactionCallback(
      title,
      amount,
      _selectedDate,
    );

    // navigators pop method
    // close the modal after enetering a transaction
    Navigator.of(context).pop();
  }

  // showDatePicker -> calendar from which dates can be picked
  // showDatePicker returns a Future
  // not well explained for now, kind of like async
  // supports thenable
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      // then will take the result of the prev function
      // in this case Future
      // if the date hasn't been picked pickedDate will be null
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            // will read out the insets on the bottom, and add 10px to it if it overlaps with input
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(children: [
            // text field for the title of a transaction
            TextField(
              // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: _titleInputController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => _submit(),
            ),
            // text field for the amount
            // only allow numbers -> keyboardType -> TextInputType.number
            TextField(
              // onChanged: (value) {
              //   amountInput = value;
              // },
              controller: _amountInputController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              // _ meaning, whatever, idc about the arg here
              // normally, it would not let a void function be here without args
              onSubmitted: (_) => _submit(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  // if no date is chosen, render the text else render the date
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Date not chosen'
                          : 'Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  AdaptiveButton(
                    callback: _showDatePicker,
                    text: 'Choose Date',
                  )
                ],
              ),
            ),
            ElevatedButton(
              // onPressed: () {
              //   // controller.text will give the value of it
              //   addTransationFn(
              //       titleInputController.text,
              //       // parsing to double from string!
              //       double.parse(amountInputController.text));
              // submit stuff on press
              // },
              onPressed: _submit,
              child: const Text('Add'),
            ),
          ]),
        ),
      ),
    );
  }
}
