import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSumOfDay = 0;
        int i;

        for (i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSumOfDay += recentTransactions[i].amount;
          }
        }

        // print(DateFormat.E().format(weekDay));
        // print(totalSum);

        return {
          'day': DateFormat.E().format(weekDay),
          'amount': totalSumOfDay,
        };
      },
    );
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
      0.0,
      (sum, item) {
        return (sum + item['amount']);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: groupedTransactionValues.map((data) {
            //return Text('${data['amount']}: ${data['amount']}');
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0
                      ? 0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
