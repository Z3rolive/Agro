import 'package:agro/models/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  var url = "http://192.168.0.108/agro/appApi/order.php";
  var url2="http://192.168.0.108/agro/appApi/totalOrder.php";
  @override
  Widget build(BuildContext context) {
    final username=ScopedModel.of<CartModel>(context, rebuildOnChange: false).useremail;
    final uid=ScopedModel.of<CartModel>(context, rebuildOnChange: false).userid;
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
        title: Text("Cart"),
        actions: <Widget>[
          FlatButton(
              child: Text(
                "Clear",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                ScopedModel.of<CartModel>(context).clearCart();
                orderToast('Cart Cleared');
              } )
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
                          http.post(url2, body: {
                            "farmer_email" :'$username',
                            "total_cost" : '$totalAm',
                            "farmer_uid" : '$uid'
                          });
                          Navigator.pop(context, '/order');
                          orderToast('Your order has been placed!');
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
  orderToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color(0xff21C58E),
        textColor: Colors.white);
  }
}
