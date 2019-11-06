import 'package:agro/order/product.dart';
class ProductsRepository {
  static List<Product> loadProducts(Category category) {
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
        imgUrl: "assets/plant.png ",
        qty: 1),
  ];
  if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) => p.category == category).toList();
    }
    }
}