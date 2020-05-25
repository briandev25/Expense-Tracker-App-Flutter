//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FancyButton  extends StatelessWidget {
  final Function addnew;
  FancyButton(this.addnew);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: addnew,
      fillColor: Colors.deepOrange,
      splashColor: Colors.orange,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical:15,
          horizontal: 20,
        ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
          Icons.explore,
          color: Colors.amber,
        ),
        SizedBox(
          width: 8,
        ),
                  Text("Add Transaction",
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        
                ],
              ),
      ),
      shape: StadiumBorder(),
     );
  }
}