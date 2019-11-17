import 'package:agro/models/product.dart';
class ProductsRepository {
  static List<Product> loadProducts(Category category) {
  List<Product> allProducts = <Product>[
    Product(
      category: Category.fertilizer,
        id: 1,
        title: "Urea",
        isFeatured: true,
        price: 20.0,
        imgUrl: "assets/sack.png",
        qty: 1),
    Product(
      category: Category.fertilizer,
        id: 2,
        title: "Manure",
        isFeatured: true,
        price: 40.0,
        imgUrl: "assets/sack.png",
        qty: 1),
    Product(
      isFeatured: false,
      category: Category.seed,
        id: 3,
        title: "Pea",
        price: 20.0,
        imgUrl: "assets/seed.png",
        qty: 1),
    Product(
      category: Category.seed,
        id: 4,
        isFeatured: true,
        title: "Pumpkin",
        price: 40.0,
        imgUrl: "assets/seed.png",
        qty: 1),
    Product(
      category: Category.plant,
      isFeatured: true,
        id: 5,
        title: "Cabbage",
        price: 25.0,
        imgUrl: "assets/plant.png",
        qty: 1),
        Product(
      category: Category.plant,
      isFeatured: false,
        id: 6,
        title: "Cauliflower",
        price: 25.0,
        imgUrl: "assets/plant.png",
        qty: 1),
        Product(
        category: Category.plant,
        id: 7,
        isFeatured: true,
        title: "Papaya",
        price: 25.0,
        imgUrl: "assets/plant.png",
        qty: 1),
        Product(
      category: Category.plant,
        id: 8,
        isFeatured: false,
        title: "Lemon",
        price: 25.0,
        imgUrl: "assets/plant.png",
        qty: 1),
  ];
  if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) => p.category == category).toList();
    }
    }
}