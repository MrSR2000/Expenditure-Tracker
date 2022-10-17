import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenditure Tracker',
      // theme: theme.copyWith(
      //   colorScheme: theme.colorScheme.copyWith(
      //     primary: Color.fromARGB(255, 20, 69, 22),
      //     secondary: Color.fromARGB(255, 86, 118, 49),
      //   ),
      // ),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Color.fromARGB(255, 13, 67, 15),
        // colorScheme: ColorScheme.dark(
        //   secondary: Colors.red,
        //   primary: Colors.white,
        //   background: Colors.green,
        // ),
        // buttonTheme: ButtonThemeData(
        //   buttonColor: Color.fromARGB(255, 86, 118, 49),
        // ),
        fontFamily: 'QuickSans',

        // appBarTheme: AppBarTheme(
        //   textTheme: ThemeData.light().textTheme.copyWith(
        //         headline6: TextStyle(
        //           fontFamily: 'Black',
        //           fontWeight: FontWeight.w600,
        //           fontSize: 22,
        //         ),
        //       ),
        // ),

        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'Larissa',
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput = 'g';

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Shoes',
    //   amount: 3000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Groceries',
    //   amount: 900,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenditure Tracker',
          style: TextStyle(
            fontFamily: 'Black',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransaction),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
