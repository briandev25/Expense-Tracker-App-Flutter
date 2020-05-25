import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Models/transaction.dart';
//import 'package:intl/intl.dart';
import './widgets/transactionList.dart';
import './widgets/newTransaction.dart';
//import './widgets/userTransactions.dart';
import './widgets/fancyButton.dart';
import './widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]
  );
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
          button: TextStyle(color: Colors.white)
        )

      ),
      title: 'Flutter Demo',
      home: Expenses(),
    );
  }
}

//class MyHomePage extends StatefulWidget {
 // @override
 // _MyHomePageState createState() => _MyHomePageState();
//}

class Expenses extends StatefulWidget {
 
  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Transaction> _userTransactions =[
  //  Transaction(id: 't1', title: 'Home Groceries', amount: 500, date: DateTime.now()),
   // Transaction(id: 't2', title: 'Personal Expense', amount: 200, date: DateTime.now())
  ];

   List<Transaction> get _recentTransactions{
     return _userTransactions.where((tx) {
       return tx.date.isAfter(
         DateTime.now().subtract(Duration(days: 7)),
       );
     }).toList();
   }
  

 // Offset _offset = Offset(0.4, 0.7);
  void _addTransaction(String title, double amount, DateTime choosenDate){
     final newTx = Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: choosenDate);

     setState(() {
       _userTransactions.add(newTx);
     });
  }
 void _showModal(BuildContext ctx){
   showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(_addTransaction));
   });
 }
   void _deleteTransaction (String id) {
       setState(() {
         _userTransactions.removeWhere((tx) => tx.id == id );
       });
   }
  // @override
  //  Widget build(BuildContext context) {
  //   return Transform(  // Transform widget
  //     transform: Matrix4.identity()
  //       ..setEntry(3, 2, 0.001) // perspective
  //       ..rotateX(_offset.dy)
  //       ..rotateY(_offset.dx),
  //     alignment: FractionalOffset.center,
  //     child: _defaultApp(context),
  //   );
  // }

  Widget chooseAppBar(){
    return Platform.isIOS ? CupertinoNavigationBar(
         middle: Text('Expense Tracker App'),
    ) : AppBar(
        title: Text('Expense Tracker App'),
       actions: <Widget>[
         IconButton(icon: Icon(Icons.add), onPressed: () =>_showModal(context), )
       ],
        
      );
  }
  Widget build (BuildContext context) {
        final PreferredSizeWidget appbar = chooseAppBar();
    final  bodyPage =  SingleChildScrollView(
                         child: Column(
                          children: <Widget>[
                    
                  Container( height: (MediaQuery.of(context).size.height - appbar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3, child: Chart(_recentTransactions),),   
                  Container(height: (MediaQuery.of(context).size.height- appbar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7, child: TransactionList(_userTransactions, _deleteTransaction),), 
              ],

            ),
                );
    
              
              
      
      
    
    return Platform.isIOS ? CupertinoPageScaffold(

      child: bodyPage,
      navigationBar: appbar,
      ) :Scaffold(
      appBar: appbar,
      body: bodyPage,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FancyButton(() =>_showModal(context)),
    );
  }
}
