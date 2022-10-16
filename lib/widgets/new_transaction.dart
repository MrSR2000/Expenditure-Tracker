import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    //print(enteredTitle);

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop(); //closes top most screen opened
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            // onChanged: (value) {
            //   titleInput = value;
            // },
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Expenditure name',
            ),
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            // onChanged: (value) {
            //   amountInput = value;
            // },
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
            onSubmitted: (_) => submitData(),
          ),
          TextButton(
            onPressed: submitData,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Add Transaction'),
          )
        ]),
      ),
    );
  }
}
