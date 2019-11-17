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
    @required this.isFeatured
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
  final bool isFeatured;
}

