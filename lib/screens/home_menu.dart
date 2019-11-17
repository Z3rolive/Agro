import 'package:agro/Repositories/product_repository.dart';
import 'package:agro/constants/constant.dart';
import 'package:agro/models/cartmodel.dart';
import 'package:agro/models/product.dart';
import 'package:agro/pages/querypage.dart';
import 'package:agro/utils/Sensor_front.dart';
import 'package:agro/utils/featured_docs.dart';
import 'package:agro/utils/featured_products.dart';
import 'package:agro/utils/query_front.dart';
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
    return Scaffold(
    backgroundColor: Colors.white54,
      body: ListView(
        children: <Widget>[
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/Header.png',
                fit: BoxFit.contain,
              )),
          QueryFront(),
          HotList(),
          DocList(),
          Monitoring(),
        ],
      ),
    );
  }
}
