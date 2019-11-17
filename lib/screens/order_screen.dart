import 'package:agro/models/cartmodel.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:line_icons/line_icons.dart';
import 'package:scoped_model/scoped_model.dart';
class Database extends StatefulWidget {
  @override
  _DatabaseState createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  String user;
  @override
  void initState() { 
  postUser();
    super.initState();
    
  }
  postUser(){
    var url = "http://192.168.0.108/agro/appApi/getOrder.php";
    user=ScopedModel.of<CartModel>(context, rebuildOnChange: false).useremail;
    http.post(url, body: {
      "Email":"$user"
    });
  }
  Future<List> getData() async {
    final response = await http.get('http://192.168.0.108/agro/appApi/getOrder.php');
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        final x = list[i];
        return Card(
          color: Color(0xff6B8E23),
          child: ListTile(
            leading: Icon(LineIcons.shopping_cart),
            title: Text('Item: '+x['plant_name']),
            subtitle: Text('Quantity: '+x['quantity']),
            trailing: Text(x['amount']),
          ),
        );
      },
    );
  }
}

