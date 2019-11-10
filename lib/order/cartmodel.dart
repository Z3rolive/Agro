import 'dart:convert';

import 'package:agro/order/product.dart';
import 'package:agro/order/product_repository.dart';
import 'package:agro/screens/order_screen.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<Product> _availableProducts;
  // The currently selected category of products.
  Category _selectedCategory = Category.all;

  Category get selectedCategory => _selectedCategory;
  List<Product> cart = [];
  double totalCartValue = 0;
  double totalCount = 0;
  int cartIndex = 0;
  var useremail = "";

  int get total => cart.length;
  void indexCountAdd() {
    totalCount = totalCount + 1;
  }

  void indexCountRemove() {
    totalCount = totalCount - 1;
  }

  void addProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    print(index);
    if (index != -1) {
      updateProduct(product, product.qty + 1);
    } else {
      cart.add(product);
      indexCountAdd();
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].qty = 1;
    cart.removeWhere((item) => item.id == product.id);
    calculateTotal();
    notifyListeners();
  }

  itemCountIndex() {
    cartIndex = cart.length;
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].qty = qty;
    if (cart[index].qty == 0) {
      removeProduct(product);
      indexCountRemove();
    }
    /* else{
      indexCountRemove();
    } */
    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.qty = 1);
    cart = [];
    totalCount = 0;
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue += f.price * f.qty;
    });
  }

  List<Product> getProducts() {
    if (_availableProducts == null) {
      return <Product>[];
    }

    if (_selectedCategory == Category.all) {
      return List<Product>.from(_availableProducts);
    } else {
      return _availableProducts
          .where((Product p) => p.category == _selectedCategory)
          .toList();
    }
  }

  void loadProducts() {
    _availableProducts = ProductsRepository.loadProducts(selectedCategory);
    notifyListeners();
  }

  void setCategory(Category newCategory) {
    _selectedCategory = Category.all;
    notifyListeners();
  }

  void setUser(email) {
    useremail = email;
    notifyListeners();
  }
}
