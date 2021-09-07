import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user.dart';
import 'package:flutter/cupertino.dart';

class AllProductsProvider extends ChangeNotifier {
  List<Product> _items = [];

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