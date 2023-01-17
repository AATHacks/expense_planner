import 'dart:io';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/Transaction.dart';

void main() {
  /*  WidgetsFlutterBinding.ensureInitialized();
  //Device orientation settings
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('hello world');

    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand'),

      //  debugShowCheckedModeBanner:
      //     false, //false it to disable debug banner at top
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*  final textController = TextEditingController();
  final priceController = TextEditingController(); */
  final List<Transaction> _userTransactions = [
    Transaction(
        title: "Shoes",
        amount: 69.99,
        date: DateTime.now(),
        id: DateTime.now().toString()),
    Transaction(
        title: "T-Shirt",
        amount: 19.55,
        date: DateTime.now().subtract(Duration(days: 1)),
        id: DateTime.now().subtract(Duration(days: 1)).toString()),
    Transaction(
        title: "Bag",
        amount: 49,
        date: DateTime.now().subtract(Duration(days: 2)),
        id: DateTime.now().subtract(Duration(days: 2)).toString()),
    Transaction(
        title: "Files",
        amount: 5.50,
        date: DateTime.now().subtract(Duration(days: 3)),
        id: DateTime.now().subtract(Duration(days: 3)).toString()),
    Transaction(
        title: "Snacks",
        amount: 6.99,
        date: DateTime.now().subtract(Duration(days: 4)),
        id: DateTime.now().subtract(Duration(days: 4)).toString()),
    Transaction(
        title: "Flowers",
        amount: 2,
        date: DateTime.now().subtract(Duration(days: 5)),
        id: DateTime.now().subtract(Duration(days: 5)).toString()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosendate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosendate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          ) as ObstructingPreferredSizeWidget
        : AppBar(
            title: const Text(
              'Personal Expense',
              style: TextStyle(
                  fontFamily: 'Opensans',
                  fontWeight: FontWeight.bold,
                  color: Colors.white54),
            ),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add),
              ),
            ],
          );
    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.75,
        child: TransactionList(_userTransactions, _deleteTransaction));
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Show Chart',
                      style:
                          TextStyle(fontFamily: 'Opensans', color: Colors.grey)
                              .merge(Theme.of(context).textTheme.titleMedium),
                    ),
                    Switch.adaptive(
                      activeColor: Colors.purple[300],
                      value: _showChart,
                      onChanged: (val) {
                        setState(
                          () {
                            _showChart = val;
                          },
                        );
                      },
                    ),
                  ],
                ),
              if (!isLandscape)
                Container(
                    height: (mediaQuery.size.height -
                            appbar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.25,
                    child: Chart(_recentTransactions)),
              if (!isLandscape) txListWidget,
              if (isLandscape)
                _showChart
                    ? Container(
                        height: (mediaQuery.size.height -
                                appbar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child: Chart(_recentTransactions),
                      )
                    : txListWidget
            ]),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appbar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appbar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add_rounded),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
