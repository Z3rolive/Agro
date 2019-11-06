import 'package:agro/order/cartpage.dart';
import 'package:agro/order/cartmodel.dart';
import 'package:agro/order/product.dart';
import 'package:agro/order/productView.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:math';
import 'package:agro/order/product_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> allProducts = <Product>[
    Product(
      category: Category.fertilizer,
        id: 1,
        title: "Urea",
        price: 20.0,
        imgUrl: "assets/sack.png",
        qty: 1),
    Product(
      category: Category.fertilizer,
        id: 2,
        title: "Manure",
        price: 40.0,
        imgUrl: "assets/sack.png",
        qty: 1),
    Product(
      category: Category.seed,
        id: 3,
        title: "Pea",
        price: 20.0,
        imgUrl: "assets/seed.png",
        qty: 1),
    Product(
      category: Category.seed,
        id: 4,
        title: "Pumpkin",
        price: 40.0,
        imgUrl: "assets/seed.png",
        qty: 1),
    Product(
      category: Category.plant,
        id: 5,
        title: "Tomato",
        price: 25.0,
        imgUrl: "assets/plant.png",
        qty: 1),
        Product(
      category: Category.plant,
        id: 5,
        title: "Cauliflower",
        price: 25.0,
        imgUrl: "assets/plant.png",
        qty: 1),
  ];
  @override
  Widget build(BuildContext context) {
    var _count = ScopedModel.of<CartModel>(context, rebuildOnChange: true)
        .totalCount
        .truncate();
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        title: Text("Products"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                },
                child: new Stack(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                    new Positioned(
                      child: new Stack(
                        children: <Widget>[
                          new Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.red[700]),
                          new Positioned(
                              top: 3.0,
                              right: 7,
                              child: new Center(
                                child: new Text(
                                  '$_count',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /* IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage())),
          ) */
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: allProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 0.8),
        itemBuilder: (context, index){
          return ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
            return Card(  
              child: Column( children: <Widget>[
              Image.asset(allProducts[index].imgUrl, height: 100, width: 100,),
              Text(allProducts[index].title, style: TextStyle(fontWeight: FontWeight.bold),),
              Text("\$"+allProducts[index].price.toString()),
              OutlineButton(
                    child: Text("Add"),
                    onPressed: () {
                       model.addProduct(allProducts[index]);
                       }
                    ),
            ])); 
          });
        },
      ), /* ScopedModelDescendant<CartModel>(
          builder: (BuildContext context, Widget child, CartModel model) {
        return ProductView(products: model.getProducts());
      }), */

      // ListView.builder(
      //   itemExtent: 80,
      //   itemCount: _products.length,
      //   itemBuilder: (context, index) {
      //     return ScopedModelDescendant<CartModel>(
      //         builder: (context, child, model) {
      //       return ListTile(
      //           leading: Image.network(_products[index].imgUrl),
      //           title: Text(_products[index].title),
      //           subtitle: Text("\$"+_products[index].price.toString()),
      //           trailing: OutlineButton(
      //               child: Text("Add"),
      //               onPressed: () => model.addProduct(_products[index])));
      //     });
      //   },
      // ),
    );
  }
}
