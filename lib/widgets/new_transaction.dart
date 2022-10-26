import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.parse('0000-00-00');

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDate == DateTime.parse('0000-00-00')) {
      return;
    }

    //print(enteredTitle);

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop(); //closes top most screen opened
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      //print('yo');
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    //print('yo paxi');
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
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Expenditure name',
            ),
            textInputAction: TextInputAction.next,
          ),
          TextField(
            // onChanged: (value) {
            //   amountInput = value;
            // },
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  //used expanded to push choose date to left side
                  child: Text(
                    _selectedDate == DateTime.parse('0000-00-00')
                        ? 'Date not selected'
                        : 'Picked date: ${DateFormat.yMMMMd().format(_selectedDate)}',
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 12, 93, 15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Choose Date'),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            style: ElevatedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 12, 93, 15),
              backgroundColor: Color.fromARGB(255, 204, 236, 204),
            ),
            child: const Text('Add Transaction'),
          )
        ]),
      ),
    );
  }
}
