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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            // onChanged: (value) {
            //   titleInput = value;
            // },
            controller: titleInputController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            // onChanged: (value) {
            //   amountInput = value;
            // },
            controller: amountInputController,
            decoration: InputDecoration(labelText: 'Amount'),
          ),
          TextButton(
              onPressed: () {
                // controller.text will give the value of it
                addTransationFn(
                    titleInputController.text,
                    // parsing to double from string!
                    double.parse(amountInputController.text));
              },
              child: Text('Add'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.pink))),
        ]),
      ),
    );
  }
}
