import 'package:agro/constants/constant.dart';
import 'package:agro/order/cartmodel.dart';
import 'package:agro/pages/querypage.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  String username;
  userDefine() {
    username =
        ScopedModel.of<CartModel>(context, rebuildOnChange: true).useremail;
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.3,
            0.4,
            1
          ],
              colors: [
            Color(0xff4BB87F),
            Color(0xffE7EAF0),
            Color(0xffE7EAF0)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/Header.png',
                      fit: BoxFit.contain,
                    )),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff4BB87F),
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(40))
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Ask Query'),
                        leading: Icon(LineIcons.question),
                        trailing: Icon(LineIcons.align_right),
                        onTap: () {
                          Navigator.pushNamed(context, '/query');
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Order Materials'),
                        leading: Icon(LineIcons.shopping_cart),
                        trailing: Icon(LineIcons.align_right),
                        onTap: () {
                          Navigator.pushNamed(context, '/order');
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text('View Documentations'),
                        leading: Icon(LineIcons.book),
                        trailing: Icon(LineIcons.align_right),
                        onTap: () {
                          Navigator.pushNamed(context, '/library');
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text('News and Updates'),
                        leading: Icon(LineIcons.newspaper_o),
                        trailing: Icon(LineIcons.align_right),
                        onTap: () {
                          Navigator.pushNamed(context, '/news');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
