import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_data_class.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.mediaQuery,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    /*  OLD LIST STYLE
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
              ); */
    // NEW LIST STYLE

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${transaction.amount}',
                  style: const TextStyle(
                      color: Colors.white60, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(transaction.date),
          style: TextStyle(color: Colors.grey[700]),
        ),
        trailing: mediaQuery.size.width > 500
            ? ElevatedButton.icon(
                icon: const Icon(Icons.delete_forever),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).errorColor,
                    elevation: 0),
                onPressed: () {
                  deleteTransaction(transaction.id);
                },
                label: const Text('Delete'),
              )
            : IconButton(
                icon: const Icon(Icons.delete_forever),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTransaction(transaction.id);
                },
              ),
      ),
    );
  }
}
