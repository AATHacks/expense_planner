import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('hello world');
    return MaterialApp(
      title: 'Personal Expense',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand'),

      //  debugShowCheckedModeBanner:
      //     false, //false it to disable debug banner at top
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
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_userTransactions, _deleteTransaction),
            ]),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
