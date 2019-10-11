import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String,Object>> get recentData{
    return List.generate(7, (index){
      var dt=DateTime.now().subtract(Duration(days: index));
      var currentDay=DateFormat.E().format(dt).substring(0,1);
      var totalSum=0.0;
      for(int j=0;j<recentTransaction.length;j++){
        if(recentTransaction[j].date.day==dt.day 
        && recentTransaction[j].date.month==dt.month
        && recentTransaction[j].date.year==dt.year){
          totalSum+=recentTransaction[j].amount;
        }
      }
      print(currentDay);
      print(totalSum.toStringAsFixed(2));
      return {'day':currentDay,'amount': totalSum};
      
    });
    
  }

  double get totalSpending{
    return recentData.fold(0.0, (sum,item){
      return sum + item['amount'];
    });
  }
  @override
  Widget build(BuildContext context) {
    print(recentData);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(children: 
        recentData.map((data){
          return ChartBar(data['day'],data['amount'] as double,(data['amount'] as double) /totalSpending);
        }).toList(),
     )
    );
  }
}