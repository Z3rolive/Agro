import 'package:agro/order/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  String username;
  double totalAm;
  var itemCount=0;
  var url = "http://192.168.100.41/agro/appApi/order.php";
  @override
  Widget build(BuildContext context) {
    final username=ScopedModel.of<CartModel>(context, rebuildOnChange: false).useremail;
    cartTotal() {
      totalAm = ScopedModel.of<CartModel>(context, rebuildOnChange: true)
          .totalCartValue;
      return totalAm;
    }
    itemCounter(){
      itemCount=ScopedModel.of<CartModel>(context,
                              rebuildOnChange: true)
                          .total;
                  return itemCount;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Cart"),
        actions: <Widget>[
          FlatButton(
              child: Text(
                "Clear",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => ScopedModel.of<CartModel>(context).clearCart())
        ],
      ),
      body: ScopedModel.of<CartModel>(context, rebuildOnChange: true)
                  .cart
                  .length ==
              0
          ? Center(
              child: Text("No items in Cart"),
            )
          : Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: ScopedModel.of<CartModel>(context,
                              rebuildOnChange: true)
                          .total,
                      itemBuilder: (context, index) {
                        return ScopedModelDescendant<CartModel>(
                          builder: (context, child, model) {
                            return ListTile(
                              title: Text(model.cart[index].title),
                              subtitle: Text(model.cart[index].qty.toString() +
                                  " x " +
                                  model.cart[index].price.toString() +
                                  " = " +
                                  (model.cart[index].qty *
                                          model.cart[index].price)
                                      .toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      model.updateProduct(model.cart[index],
                                          model.cart[index].qty + 1);
                                      // model.removeProduct(model.cart[index]);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      model.updateProduct(model.cart[index],
                                          model.cart[index].qty - 1);
                                      // model.removeProduct(model.cart[index]);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Total: \$ " + cartTotal().toString() + "",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: double.infinity,
                    child: ScopedModelDescendant<CartModel>(
                          builder: (BuildContext context ,Widget child ,CartModel model ) {
                                          return RaisedButton(
                        color: Colors.yellow[900],
                        textColor: Colors.white,
                        elevation: 0,
                        child: Text("Order Now"),
                        onPressed: () {
                          for(int i=0; i<itemCounter();i++){
                            http.post(url, body: {
                              "plant_name": model.cart[i].title,
                              "quantity":  (model.cart[i].qty).toString(),
                              "amount": "\$" + (model.cart[i].qty *
                                          model.cart[i].price)
                                          .toString(),
                              "farmer_email": '$username',
                              
                            },
                            
                            );
                            print(model.cart[i].title);
                            print ((model.cart[i].qty).toString(),);
                            print((model.cart[i].qty *
                                          model.cart[i].price)
                                          .toString(),);
                                          print('$username');
                            print("Order $i Placed!");
                          }
                          Navigator.pop(context, '/order');
                          model.clearCart();
                          
                        },
                      );
                          }
                    ),
                  ),
                ],
              ),
            ),
            
    );
  }
}
