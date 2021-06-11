import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // even though the widget is stateless, input doesn't need to render any widget so it's fine like this
  // normally you'd want stateful widget for it anyway
  // String titleInput;
  // String amountInput;

  // alternative - use controllers (listeners more like)
  final TextEditingController titleInputController = TextEditingController();
  final TextEditingController amountInputController = TextEditingController();

  final Function addTransationFn;

  NewTransaction({this.addTransationFn});

  // submit function that will trigger when user inputs both title and amount
  void submit() {
    final title = titleInputController.text;
    final amount = double.parse(amountInputController.text);

    // check if inputs are valid
    if (title.isEmpty || amount <= 0) {
      return;
    }

    addTransationFn(
      title,
      amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          // text field for the title of a transaction
          TextField(
            // onChanged: (value) {
            //   titleInput = value;
            // },
            controller: titleInputController,
            decoration: InputDecoration(labelText: 'Title'),
            onSubmitted: (_) => submit(),
          ),
          // text field for the amount
          // only allow numbers -> keyboardType -> TextInputType.number
          TextField(
            // onChanged: (value) {
            //   amountInput = value;
            // },
            controller: amountInputController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            // _ meaning, whatever, idc about the arg here
            // normally, it would not let a void function be here without args
            onSubmitted: (_) => submit(),
          ),
          TextButton(
              // onPressed: () {
              //   // controller.text will give the value of it
              //   addTransationFn(
              //       titleInputController.text,
              //       // parsing to double from string!
              //       double.parse(amountInputController.text));
              // submit stuff on press
              // },
              onPressed: submit,
              child: Text('Add'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.pink))),
        ]),
      ),
    );
  }
}
