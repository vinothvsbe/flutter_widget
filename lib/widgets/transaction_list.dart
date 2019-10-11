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
                  SizedBox(
                    height: 20,
                  ),
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
                    margin: EdgeInsets.symmetric(horizontal: 6,vertical: 8),
                    elevation: 6,
                    
                                      child: ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                                                child: FittedBox(
                                                  child: Text(
                                '\$${userTransactionList[index].amount.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                      title: Text('${userTransactionList[index].title}',style: Theme.of(context).textTheme.title,),
                      subtitle: Text('${DateFormat.yMMMd().format(userTransactionList[index].date)}'),
                    ),
                  );
                },
                itemCount: userTransactionList.length,
              ));
  }
}
