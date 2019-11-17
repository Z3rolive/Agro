import 'package:agro/order/cartpage.dart';
import 'package:agro/models/cartmodel.dart';
import 'package:agro/models/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:agro/Repositories/product_repository.dart';

const List<String> dropdownValues = [
  "All",
  "Fertilizer",
  "Seed",
  "Plant",
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //The list of values we want on the dropdown
  String currentlySelected = dropdownValues[0];
  void currentlySelection(String p) {
    setState(() {
      currentlySelected = p;
    });
  }

  addedToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white);
  }

  List<Product> allProducts =
      ProductsRepository.loadProducts(Category.all).toList();
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
          ),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return dropdownValues.map((String p) {
              return PopupMenuItem(
                  child: ListTile(
                title: Text(p),
              ));
            }).toList();
          }),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: allProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 8,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          return ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
            return Card(
                color: Color(0xff697071),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: Colors.deepOrangeAccent,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              model.addProduct(allProducts[index]);
                              addedToast('Added to Cart');
                            },
                          ),
                        ),
                      ),
                      Image.asset(
                        allProducts[index].imgUrl,
                        height: 100,
                        width: 100,
                      ),
                      Text(
                        allProducts[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("\$" + allProducts[index].price.toString()),
                    ]));
          });
        },
      ),
    );
  }
}
