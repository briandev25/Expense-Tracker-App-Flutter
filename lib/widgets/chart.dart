import 'package:flutter/material.dart';
 import '../Models/transaction.dart';
 import 'package:intl/intl.dart';
 import './chartBar.dart';

class Chart extends StatelessWidget {

   final List<Transaction> recentTransactions;
    Chart(this.recentTransactions);
   List<Map<String,Object>> get transactionValues{
     return List.generate(7, (index) {
       final weekDay = DateTime.now().subtract(Duration(days: index),);
        var totalSum =0.0;

          for(var i = 0; i<transactionValues.length; i++){
            if(recentTransactions[i].date.day== weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
             recentTransactions[i].date.year == weekDay.year
            ){
                  totalSum+=recentTransactions[i].amount;
           }
         }

          return {"day":DateFormat.E().format(weekDay).substring(0, 1) ,"amount":totalSum};

          
         
     }
    ).reversed.toList();
     

   }
    double get totaSpending {
      return transactionValues.fold(0.0, (sum, valley) {
        return sum + valley['amount'];
      });
    }

  @override
  Widget build(BuildContext context) {
    // print(transactionValues);
    return   Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                       child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: transactionValues.map((tx) {
                        return Flexible(
                          fit: FlexFit.tight,
                                  child: ChartBar(tx['day'], tx['amount'],
                                   totaSpending == 0.0 ? 0.0 :(tx['amount'] as double) / totaSpending),
                        );
                      }).toList(),
                          
                      
                    ),
                  ),
                  elevation: 6,
                  margin: EdgeInsets.all(20),
                  
    );
    
  }
}