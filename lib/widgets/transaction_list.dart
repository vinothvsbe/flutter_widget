import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactionList;
  TransactionList(this.userTransactionList);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: (userTransactionList.length <= 0)
            ? Column(
                children: <Widget>[
                  Text('Looks like you need to start something'),
                  SizedBox(height: 20,),
                  Container(
                    height: 300,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            '\$ ${userTransactionList[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userTransactionList[index].title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd hh:mm a')
                                  .format(userTransactionList[index].date),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: userTransactionList.length,
              ));
  }
}
