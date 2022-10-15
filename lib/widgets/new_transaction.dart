import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;

  NewTransaction(this.addTransaction);

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
          ),
          TextField(
            // onChanged: (value) {
            //   amountInput = value;
            // },
            controller: amountController,
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
          ),
          TextButton(
            onPressed: () {
              print(titleController.text);
              print(amountController.text);
              addTransaction(
                  titleController.text, double.parse(amountController.text));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('Add Transaction'),
          )
        ]),
      ),
    );
    ;
  }
}
