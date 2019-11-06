import 'package:agro/constants/constant.dart';
import 'package:agro/order/product.dart';
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
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage('assets/Header.png'),
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add_circle),
                tooltip: 'Add new entry',
                onPressed: () {},
              ),
            ],
            floating: true,
            pinned: true,
            elevation: 0,
          ),
          SliverFillRemaining(

            child: SingleChildScrollView(
              child: Padding(
                   padding: const EdgeInsets.all(20.0),
                
                                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 50),
                      Text("${content.title}",style: kTitleStyle),
                      SizedBox(height:20),
                         Text("${content.contents}",style: kSubtitleStyle
                        ),
                    ],
                  ),
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}
