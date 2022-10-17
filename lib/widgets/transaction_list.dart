import 'package:expenditure_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No expenditure added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/blank.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              //needs parent to tell the hize i.e. height of container
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 6,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      // backgroundImage: NetworkImage(
                      //     'https://c8.alamy.com/comp/2DXN8GB/us-dollar-border-with-empty-middle-area-2DXN8GB.jpg'),
                      radius: 30,
                      backgroundColor: const Color.fromARGB(255, 214, 210, 210),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: FittedBox(
                          child: Text(
                            'RS. ${transactions[index].amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
