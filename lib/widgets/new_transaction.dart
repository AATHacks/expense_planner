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
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_priceController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredPrice = double.parse(_priceController.text);

    if (enteredPrice <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredPrice,
      _selectedDate as DateTime,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            controller: _priceController,
            keyboardType: TextInputType.numberWithOptions(),
            onSubmitted: (_) => _submitData(),
          ),
          Row(
            children: [
              Expanded(
                child: Text(_selectedDate == null
                    ? 'No date choosen!'
                    : 'Picked Date : ${DateFormat.yMd().format((_selectedDate as DateTime))}'),
              ),
              TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose Date',
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
              onPressed: _submitData,
              child: Text(
                'Add Transaction',
              )),
        ],
      ),
    );
  }
}
