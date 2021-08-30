import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

class RecentlyViewedProvider extends ChangeNotifier {
  List<Product> _items = [
    new Product(name: 'name', price: 220, sale: 10),
    new Product(name: 'name', price: 400, sale: 20),
  ];

  List<Product> get items => _items;

  removeItem(Product product){
    _items.remove(product);
    notifyListeners();
  }

}