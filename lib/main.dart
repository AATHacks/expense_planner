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
      debugShowCheckedModeBanner:
          true, //false it to disable debug banner at top
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

  /* String titleInput = '';
  String priceInput = ''; */
  final textController = TextEditingController();
  final priceController = TextEditingController();
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
              Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: textController,
                      /*  onChanged: ((value) {
                          titleInput = value;
                        }) */
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Price'),
                      controller: priceController,
                      /*  onChanged: ((value) {
                          priceInput = value;
                        }) */
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.purple,
                            textStyle: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          print(textController.text);
                          print(priceController.text);
                          /* print(titleInput);
                          print(priceInput); */
                        },
                        child: Text('Add Transaction')),
                  ],
                ),
              ),
              Column(
                children: transactions.map((tx) {
                  return Card(
                    child: Row(children: [
                      Container(
                        //purple price box
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
