import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620,
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
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}',
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        deleteTransaction(transactions[index].id);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
