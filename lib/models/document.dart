import 'package:flutter/material.dart';

class Document{
  Document({
    @required this.title,
    @required this.imgUrl,
    @required this.contents,
  }) : assert(title != null),
       assert(imgUrl != null),
       assert(contents != null);
       

  final contents;
  final String title;
  final String imgUrl;
}