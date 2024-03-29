import 'dart:io';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/transaction_data_class.dart';

void main() {
  /*  WidgetsFlutterBinding.ensureInitialized();
  //Device orientation settings
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('hello world');

    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          // ignore: deprecated_member_use
          accentColor: Colors.amber,
          fontFamily: 'Quicksand'),

      //  debugShowCheckedModeBanner:
      //     false, //false it to disable debug banner at top
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*  final textController = TextEditingController();
  final priceController = TextEditingController(); */

  //this is the map to store transactions
  final List<Transaction> _userTransactions = [
    Transaction(
        title: "Shoes",
        amount: 69.99,
        date: DateTime.now(),
        id: DateTime.now().toString()),
    Transaction(
        title: "T-Shirt",
        amount: 19.55,
        date: DateTime.now().subtract(const Duration(days: 1)),
        id: DateTime.now().subtract(const Duration(days: 1)).toString()),
    Transaction(
        title: "Bag",
        amount: 49,
        date: DateTime.now().subtract(const Duration(days: 2)),
        id: DateTime.now().subtract(const Duration(days: 2)).toString()),
    Transaction(
        title: "Files",
        amount: 5.50,
        date: DateTime.now().subtract(const Duration(days: 3)),
        id: DateTime.now().subtract(const Duration(days: 3)).toString()),
    Transaction(
        title: "Snacks",
        amount: 6.99,
        date: DateTime.now().subtract(const Duration(days: 4)),
        id: DateTime.now().subtract(const Duration(days: 4)).toString()),
    Transaction(
        title: "Flowers",
        amount: 2,
        date: DateTime.now().subtract(const Duration(days: 5)),
        id: DateTime.now().subtract(const Duration(days: 5)).toString()),
  ];

  //this is used for landscape mode for chart on/off button
  bool _showChart = false;

  //this is used to get last 7 days user transactions
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  //add new transaction to usertransaction map
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

  //this method is used to get model bottom sheet
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

  //this method is used to delete transaction from map
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> _buildLandscapeView(MediaQueryData mediaQuery,
      PreferredSizeWidget appbar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Show Chart',
            style: const TextStyle(fontFamily: 'Opensans', color: Colors.grey)
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
      _showChart
          ? SizedBox(
              height: (mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitView(MediaQueryData mediaQuery,
      PreferredSizeWidget appbar, Widget txListWidget) {
    return [
      SizedBox(
          height: (mediaQuery.size.height -
                  appbar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.25,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    print('build() main');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
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
                icon: const Icon(Icons.add),
              ),
            ],
          );
    final txListWidget = SizedBox(
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
                ..._buildLandscapeView(mediaQuery, appbar, txListWidget),
              if (!isLandscape)
                ..._buildPortraitView(mediaQuery, appbar, txListWidget),
            ]),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appbar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appbar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add_rounded),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
