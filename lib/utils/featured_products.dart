import 'package:agro/Repositories/product_repository.dart';
import 'package:agro/constants/constant.dart';
import 'package:agro/models/product.dart';
import 'package:flutter/material.dart';

class HotList extends StatelessWidget {
  final List<Product> hotlist = ProductsRepository.loadProducts(Category.all)
      .where((Product p) => p.isFeatured == true)
      .toList();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Featured Products',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              GestureDetector(
                child: Text(
                  'View All>>',
                  style: TextStyle(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/order');
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
                    Navigator.pushNamed(context, '/order');
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
                          Text(hotlist[i].title, style: kSubtitleStyle,),
                          Text('\$ ' + (hotlist[i].price).toString())
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
