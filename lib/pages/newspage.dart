import 'package:agro/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(LineIcons.exclamation_triangle, size: 100),
              Text('PAGE UNDER CONSTRUCTION', style: kSubtitleStyle),
              Text('Tap Anywhere to Exit')
            ],
          ),
        ),
      ),
    );
  }
}
