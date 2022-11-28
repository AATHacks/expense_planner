import 'package:flutter/material.dart';
import 'Transaction.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(title: "Shoes", amount: 56.99, date: DateTime.now(), id: "id1"),
    Transaction(
        title: "T-Shirt", amount: 19.55, date: DateTime.now(), id: "id2"),
    Transaction(
        title: "Sunglasses", amount: 56.99, date: DateTime.now(), id: "id3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  elevation: 5,
                  child: Text('CHART!'),
                ),
              ),
              Column(
                children: transactions.map((tx) {
                  return Card(
                    child: Row(children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '\$${tx.amount}', // ---> String interpolation to write $55 dollor sign plus amount
/*                           tx.amount.toString(),
 */
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx.title,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
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
              )
            ]));
  }
}
