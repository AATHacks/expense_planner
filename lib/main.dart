import 'package:flutter/material.dart';
import 'Transaction.dart';

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
                        child: Text(
                          tx.amount.toString(),
                        ),
                      ),
                      Column(children: [
                        Text(tx.title),
                        Text(
                          tx.date.toString(),
                        ),
                      ])
                    ]),
                  );
                }).toList(),
              )
            ]));
  }
}
