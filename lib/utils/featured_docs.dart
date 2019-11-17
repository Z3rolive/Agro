import 'package:agro/Repositories/document_repository.dart';
import 'package:agro/models/document.dart';
import 'package:agro/models/product.dart';
import 'package:agro/pages/contentpage.dart';
import 'package:flutter/material.dart';

class DocList extends StatelessWidget {
  final List<Document> hotlist = DocumentsRepository.loadDocs();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Featured Documents',
                  style: TextStyle(
                      color: Color(0xff4D5F80),
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              GestureDetector(
                child: Text(
                  'View All>>',
                  style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/library');
                },
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          height: 180,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: hotlist.length,
              itemBuilder: (BuildContext context, int i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContentPage(content: hotlist[i]),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.only(right: 10, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 5.0,
                        )
                      ],
                    ),
                    child: Card(
                      color: Color(0xff68768A),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset(
                            hotlist[i].imgUrl,
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                          ),
                          Text(hotlist[i].title),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
