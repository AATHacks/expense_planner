import 'package:flutter/material.dart';
import '../models/transaction_data_class.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(this.transactions, this.deleteTransaction, {super.key});
  @override
  Widget build(BuildContext context) {
    print('build() transaction list');
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
              return TransactionItem(
                  transaction: transactions[index],
                  mediaQuery: mediaQuery,
                  deleteTransaction: deleteTransaction);
            },
          );
  }
}
