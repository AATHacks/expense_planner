import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import './user_transaction.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredPrice = double.parse(priceController.text);

    if (enteredPrice <= 0 || enteredTitle.isEmpty) {
      return;
    }
    addTx(
      enteredTitle,
      enteredPrice,
    );
  }

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
            onSubmitted: (value) => submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Price'),
            controller: priceController,
            keyboardType: TextInputType.numberWithOptions(),
            onSubmitted: (value) => submitData(),
          ),
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.purple,
                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: submitData,
              child: Text('Add Transaction')),
        ],
      ),
    );
  }
}
