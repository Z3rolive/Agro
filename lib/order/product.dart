import 'package:flutter/material.dart';
enum Category {
  all,
  seed,
  fertilizer,
  plant
}
class Product {

 Product({
    @required this.id,
    @required this.title,
    @required this.category,
    @required this.price,
    @required this.imgUrl,
    @required this.qty,
  }) : assert(category != null),
       assert(id != null),
       assert(price != null),
       assert(title != null),
       assert(imgUrl != null),
       assert(qty != null);

  final Category category;
  final int id;
  final String title;
  final String imgUrl;
  final double price;
        int qty;
}

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