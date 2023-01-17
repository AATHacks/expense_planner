import 'package:flutter/material.dart';
import '../models/transaction_data_class.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(this.transactions, this.deleteTransaction, {super.key});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? Container(
            alignment: Alignment.center,
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            }),
          )
        : ListView.builder(
            shrinkWrap: true,
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
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}',
                            style: const TextStyle(
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
                  trailing: mediaQuery.size.width > 500
                      ? ElevatedButton.icon(
                          icon: const Icon(Icons.delete_forever),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Theme.of(context).errorColor,
                              elevation: 0),
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                          label: const Text('Delete'),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete_forever),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                        ),
                ),
              );
            },
          );
  }
}
