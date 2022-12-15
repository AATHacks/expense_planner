import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView(
        children: transactions.map((tx) {
          return Card(
            child: Row(children: [
              Container(
                //purple price box
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
                child: Text(
                  //price text
                  '\$${tx.amount}', // ---> String interpolation to write $55 dollor sign plus amount
                  /*tx.amount.toString(),*/
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ),
              Column(
                  //item name and date
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title, //item name
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat.yMMMd().format(tx
                          .date), // ------> formatting date using intl library "Nov 20, 2022" this type
                      style: TextStyle(color: Colors.grey),
                    ),
                  ])
            ]),
          );
        }).toList(),
      ),
    );
  }
}
