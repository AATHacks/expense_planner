import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final priceController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredPrice = double.parse(priceController.text);

    if (enteredPrice <= 0 || enteredTitle.isEmpty) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredPrice,
    );
    Navigator.of(context).pop();
  }

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
            decoration: InputDecoration(
              labelText: 'Price',
            ),
            controller: priceController,
            keyboardType: TextInputType.numberWithOptions(),
            onSubmitted: (value) => submitData(),
          ),
          Row(
            children: [
              Text('No date choosen!'),
              TextButton(
                  onPressed: submitData,
                  child: Text(
                    'Choose Text',
                  ),
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand')))
            ],
          ),
          ElevatedButton(
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).backgroundColor,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Quicksand')),
              onPressed: submitData,
              child: Text(
                'Add Transaction',
              )),
        ],
      ),
    );
  }
}
