import 'package:expense_planner/widgets/user_transaction.dart';

import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';

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
              /* Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  elevation: 5,
                  child: Text('CHART!'), 
                ),
              ), */
              UserTransaction(),
            ]));
  }
}
