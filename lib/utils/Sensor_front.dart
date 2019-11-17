import 'package:flutter/material.dart';

class Monitoring extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/monitoring');
      },
      child: Container(
        padding: EdgeInsets.all(20),
        height: 100,
        width: double.infinity,
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            Text('Real Time Moisture Monitoring ', 
                style: TextStyle(fontSize: 24, color: Colors.black)),
            Text('<<Click to Observe>>'),
          ],
        ),
      ),
    );
  }
}
