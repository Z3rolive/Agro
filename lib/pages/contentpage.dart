import 'package:agro/constants/constant.dart';
import 'package:agro/models/document.dart';
import 'package:agro/models/product.dart';
import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  ContentPage({this.content});
  final Document content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.grey),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage('assets/Header.png'),
                fit: BoxFit.contain,
              ),
            ),
            floating: true,
            pinned: true,
            elevation: 0,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${content.title}", style: kTitleStyle),
                  SizedBox(height: 20),
                  Text("${content.contents}", style: kSubtitleStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
