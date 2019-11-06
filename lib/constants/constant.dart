import 'package:flutter/material.dart';

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);
const kTileTitleStyle = TextStyle(fontSize: 15);
final Color iconColor = Color(0xff27ae60);

class GreenDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 10,
      indent: 50,
      endIndent: 50,
      color: Color(0xff27ae60),
    );
  }
}
class OrangeDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 2,
      indent: 70,
      endIndent: 50,
      color: Color(0xff27ae60),
    );
  }
}
