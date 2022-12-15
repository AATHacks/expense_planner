import 'package:flutter/material.dart';
import './user_transaction.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final priceController = TextEditingController();

  NewTransaction(this.addTx);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Price'),
            controller: priceController,
          ),
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.purple,
                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                addTx(
                  titleController.text,
                  double.parse(priceController.text),
                );
                /* print(titleController.text);
                print(priceController.text); */ //to print value of textbox in console (just for practice)
              },
              child: Text('Add Transaction')),
        ],
      ),
    );
  }
}
