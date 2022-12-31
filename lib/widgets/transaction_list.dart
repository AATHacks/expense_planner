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
      child: transactions.isEmpty
          ? Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              ),
            )
          : ListView.builder(
              // shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(children: [
                    Container(
                      //purple price box
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        //price text
                        '\$${transactions[index].amount.toStringAsFixed(2)}', // ---> String interpolation to write $55 dollor sign plus amount
                        /*tx.amount.toString(),*/
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context)
                              .primaryColor, //get that from main.dart
                        ),
                      ),
                    ),
                    Column(
                        //item name and date
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title, //item name
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index]
                                .date), // ------> formatting date using intl library "Nov 20, 2022" this type
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ])
                  ]),
                );
              },
            ),
    );
  }
}
