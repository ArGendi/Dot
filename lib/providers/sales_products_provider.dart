import 'package:ecommerce/constants.dart';
import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

class SalesProvider extends ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => _items;

  addItem(Product product){
    _items.add(product);
    notifyListeners();
  }

  removeItem(Product product){
    _items.remove(product);
    notifyListeners();
  }

}