import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'package:uuid/uuid.dart';
//import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);     //force app to only work in potrait mode

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
        //errorColor: Color.fromARGB(255, 81, 66, 65),
        errorColor: Color.fromARGB(255, 202, 43, 32),
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
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
    return _userTransactions.where(
      (element) {
        return element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    const uuid = Uuid();

    final newTx = Transaction(
      //id: DateTime.now().toString(),
      id: uuid.v1(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
    //print('delete');
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaquery, AppBar appBarr, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch.adaptive(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaquery.size.height -
                      appBarr.preferredSize.height -
                      mediaquery.padding.top) *
                  0.7,
              child: Chart(_recentTransaction))
          : txListWidget,
    ];
  }

  List<Widget> _buildPotraitContent(
      MediaQueryData mediaquery, AppBar appBarr, Widget txListWidget) {
    return [
      Container(
        height: (mediaquery.size.height -
                appBarr.preferredSize.height -
                mediaquery.padding.top) *
            0.3,
        child: Chart(_recentTransaction),
      ),
      txListWidget
    ];
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

  bool _showChart = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final isLandscape = mediaquery.orientation == Orientation.landscape;
    final appBarr = AppBar(
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
    );

    final txListWidget = Container(
      //padding: const EdgeInsets.all(10),
      height: (mediaquery.size.height -
              appBarr.preferredSize.height -
              mediaquery.padding.top) *
          .7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(mediaquery, appBarr, txListWidget),
            if (!isLandscape)
              ..._buildPotraitContent(mediaquery, appBarr, txListWidget),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appBarr,
      body: pageBody,
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
