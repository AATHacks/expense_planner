import './new_transaction.dart';
import 'package:flutter/material.dart';
import './transaction_list.dart';
import '../models/Transaction.dart';

class UserTransaction extends StatefulWidget {
  UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(title: "Shoes", amount: 56.99, date: DateTime.now(), id: "id1"),
    Transaction(
        title: "T-Shirt", amount: 19.55, date: DateTime.now(), id: "id2"),
    Transaction(
        title: "Sunglasses", amount: 56.99, date: DateTime.now(), id: "id3"),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
