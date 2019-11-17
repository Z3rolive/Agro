import 'package:flutter/material.dart';

class QueryFront extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/query');
      },
      child: Container(
        padding: EdgeInsets.all(20),
        height: 100,
        width: double.infinity,
        color: Colors.grey,
        child: Column(
          children: <Widget>[

            Text('Ask For Expert Opinion', style: TextStyle(fontSize: 32)),
            Text('<<Click to post your query>>')
          ],
        ),
      ),
    );
  }
}
