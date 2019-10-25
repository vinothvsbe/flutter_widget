import 'package:flutter/material.dart';
import 'package:flutter_widget/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My flutter app',
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(fontFamily: 'OpenSans', fontSize: 18, fontWeight: FontWeight.bold),
          button: TextStyle(color: Colors.white)
        ),
        
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontFamily: 'OpenSans',fontSize: 20,fontWeight: FontWeight.bold)
          )
        )
        
        
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactionList = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 3500.00, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Books', amount: 500.00, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactiion{
    return userTransactionList.where((tx){
      return  tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      //(index.date >= DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    var newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: selectedDate);
    setState(() {
      userTransactionList.add(newTx);
      userTransactionList.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void deleteSelectedTransaction(int index){   
    setState(() {
      userTransactionList.removeAt(index);
    }); 
    
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Management'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {_startAddNewTransaction(context);},
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(_recentTransactiion),
          Card(child: TransactionList(userTransactionList,deleteSelectedTransaction)),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_startAddNewTransaction(context);},
        child: Icon(Icons.add),
      )
      
    );
  }
}
