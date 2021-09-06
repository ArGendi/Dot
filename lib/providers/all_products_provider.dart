import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user.dart';
import 'package:flutter/cupertino.dart';

class AllProductsProvider extends ChangeNotifier {
  List<Product> _items = [
    new Product(name: 'product 1', price: 200),
    new Product(name: 'product 2', price: 200),
  ];

  List<Product> get items => _items;

  removeItem(Product product){
    _items.remove(product);
    notifyListeners();
  }

  addItem(Product product){
    _items.add(product);
    notifyListeners();
  }

}