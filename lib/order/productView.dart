import 'package:agro/order/cartmodel.dart';
import 'package:agro/order/product.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class ProductView extends StatelessWidget {
  ProductView({Key key, this.products, this.category=Category.all});
  final List<Product> products;
  final Category category;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 0.8),
        itemBuilder: (context, index){
          return ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
            return Card(  
              child: Column( children: <Widget>[
              Image.network(products[index].imgUrl, height: 100, width: 100,),
              Text(products[index].title, style: TextStyle(fontWeight: FontWeight.bold),),
              Text("\$"+products[index].price.toString()),
              OutlineButton(
                    child: Text("Add"),
                    onPressed: () {
                       model.addProduct(products[index]);
                       }
                    ),
            ])); 
          });
        },
      );
  }
}