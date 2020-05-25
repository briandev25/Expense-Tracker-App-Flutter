import 'package:expense_app/Models/transaction.dart';
import 'package:flutter/material.dart';
import './TransactionItem.dart';

class TransactionList  extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
                  itemBuilder: (ctx,index){
                    return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
                  },
                 // children: transactions.map((tx) { }).toList(),
                  itemCount: transactions.length,
                
    );
      
    
      
    
  }
}

