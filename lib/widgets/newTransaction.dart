import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrans;
  NewTransaction(this.addTrans);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
   final titleField = TextEditingController();

  final amountField = TextEditingController();
  DateTime pickedDate;

  void _submitData(){
    if(amountField.text.isEmpty){
      return;
    }
    final title =titleField.text;
    final amount =double.parse(amountField.text);

    if(title.isEmpty || amount<=0 || pickedDate==null){
      return;
    }
    widget.addTrans(title,amount,pickedDate);
     Navigator.of(context).pop();
  }
  void _presentDatePicker(){
    showDatePicker(context: context,
     initialDate: DateTime.now(), 
     firstDate: DateTime(2002),
      lastDate: DateTime.now()
      ).then((pickdate) {
          if(pickdate==null){
            return;
          }
          setState(() {
            pickedDate = pickdate;
          });
      });
  }

  @override
  Widget build(BuildContext context) {
    return    SingleChildScrollView(
          child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                    
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                     TextField(
                      controller: titleField,
                       onSubmitted: (_) =>_submitData(),
                      decoration: InputDecoration(
                        labelText: "Title",
                      ), 
                     ),
                     TextField(
                       keyboardType: TextInputType.number,
                       controller: amountField,
                       decoration: InputDecoration(
                         labelText: "amount",
                       ),
                       onSubmitted: (_) =>_submitData(),
                     ),
                     Container(
                       height: 70,
                       child: Row(children: [
                        Expanded(child: Text( pickedDate==null ?"No Date Chosen" : 'Picked Date :${DateFormat.yMd().format(pickedDate)}' )),
                         FlatButton(
                            textColor: Theme.of(context).primaryColor,
                           onPressed:_presentDatePicker,
                          child: Text(  "Pick a Date",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                         
                         ),
                         )
                       ],
                       ),
                     ),
                     RaisedButton( 
                       color: Theme.of(context).primaryColor,
                       textColor: Theme.of(context).textTheme.button.color,
                     child: Text("Add Transaction"),      
                     onPressed: _submitData,
                     )
                    ],
                  ),
                ),
              ),
    );
      
    
  }
}