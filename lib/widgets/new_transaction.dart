import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  DateTime _selectedDate;
  void _addNewTranx() {
    if (inputController.text.isNotEmpty &&
        (amountController.text.isNotEmpty &&
            double.tryParse(amountController.text) > 0) && 
            dateController.text.isNotEmpty) {
      final String titleText = inputController.text;
      final double amountValue = double.tryParse(amountController.text);
      final DateTime dateValue=_selectedDate;
      widget.addNewTransaction(titleText, amountValue, dateValue);
      Navigator.of(context).pop();
    }
  }

  void _prepareDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedValue) {
      if (pickedValue == null) return;

      setState(() {
        _selectedDate = pickedValue;
        dateController.text = DateFormat.yMd().format(_selectedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: inputController,
            onSubmitted: (_) => _addNewTranx(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            controller: amountController,
            onSubmitted: (_) => _addNewTranx(),
          ),
          Container(
            height: 80,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Date'),
                    controller: dateController,
                    enabled: false,
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Choose date',
                    style: TextStyle(fontWeight: FontWeight.w800),),
                  onPressed: _prepareDatePicker,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          RaisedButton(
              child: Text('Add transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _addNewTranx)
        ],
      ),
    );
  }
}
