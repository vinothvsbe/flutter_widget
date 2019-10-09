import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputController = TextEditingController();

  final amountController = TextEditingController();

  void _addNewTranx(){
    if(inputController.text.isNotEmpty && (amountController.text.isNotEmpty && double.tryParse(amountController.text)>0)){
      final String titleText=inputController.text;
      final double amountValue=double.tryParse(amountController.text);
      widget.addNewTransaction(titleText,amountValue);
      Navigator.of(context).pop();
    }
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
            onSubmitted: (_)=> _addNewTranx(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,            
            controller: amountController,
            onSubmitted: (_)=> _addNewTranx(),
          ),
          FlatButton(
              child: Text('Add transaction'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _addNewTranx
            )
        ],
      ),
    );
  }
}
