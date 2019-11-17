import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Query extends StatelessWidget {
  Future<List> getQuery() async {
    final response =
        await http.get('http://192.168.0.108/agro/appApi/getQuery.php');
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getQuery(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ItemList(
                  questionlist: snapshot.data,
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
  Future<List> getData() async {
    final response =
        await http.get('http://192.168.0.108/agro/appApi/getAnswer.php');
    return jsonDecode(response.body);
  }

  final List questionlist;
  ItemList({this.questionlist});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Answers'),
        ),
        body: FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              return snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Query')),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10))),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    questionlist[0]['query'],
                                    style: TextStyle(fontSize: 22),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text('Answer')),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    snapshot.data[0]['answer'],
                                    style: TextStyle(fontSize: 22),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}
