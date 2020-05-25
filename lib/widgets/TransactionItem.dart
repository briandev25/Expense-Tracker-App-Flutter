import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
         elevation: 5,
         margin: EdgeInsets.symmetric(
           vertical: 8,
           horizontal: 5,
         ),
         child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                    child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}'
              ),
              
            ),
          ),
        ),
        title: Text(
          transaction.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date,
        ),
        ),
        trailing:IconButton(
          color: Theme.of(context).errorColor,
          icon: Icon(
            Icons.delete,
          ), 
          onPressed: () => deleteTx(transaction.id),
      ),
         ),
    );
  }
}